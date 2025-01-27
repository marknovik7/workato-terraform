resource "aws_instance" "opa_instance" {
  ami                         = var.ami == "NONE" ? data.aws_ami.windows-2022.id : var.ami
  instance_type               = var.instance_type
  key_name                    = var.new_cert ? aws_key_pair.generated_key[0].key_name : "cs-ops"
  
  # Check if vpc_name is set, else fallback to a default
  subnet_id                   = var.subnet == "" ? element(
                                split(",", local.subnet[lookup(local.subnet, var.vpc_name, "aws-self-service")]),
                                length(data.aws_instances.provisioned_instances.ids) % length(split(",", local.subnet[lookup(local.subnet, var.vpc_name, "aws-self-service")]))
                              ) : var.subnet

  associate_public_ip_address = true
  vpc_security_group_ids      = data.aws_security_groups.workato_security_group.ids

  root_block_device {
    volume_size = var.VOLUME_SIZE
    tags        = data.aws_default_tags.opa_default_tags.tags 
    encrypted   = true
  }

  user_data = <<EOF
    <powershell>
        net user ${var.instance_username} '${random_password.password.result}' /add /y
        net localgroup administrators ${var.instance_username} /add
        wmic useraccount where "NAME=’${var.instance_username}’" set PasswordExpires=FALSE
        winrm quickconfig -q
        winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
        winrm set winrm/config '@{MaxTimeoutms="1800000"}'
        winrm set winrm/config/service '@{AllowUnencrypted="true"}'
        winrm set winrm/config/service/auth '@{Basic="true"}'
        netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
        netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow
        net stop winrm
        sc.exe config winrm start=auto
        net start winrm
        wget https://workato-public.s3.amazonaws.com/agent/workato-agent-setup-win-amd64-23.1.exe -UseBasicParsing -Outfile C:\Users\${var.instance_username}\workato-agent-setup-win-amd64-23.1.exe
    </powershell>
EOF
}

resource "time_static" "date" {}

resource "tls_private_key" "opa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  count      = var.new_cert ? 1 : 0
  key_name   = local.name
  public_key = tls_private_key.opa_key.public_key_openssh
}

data "aws_default_tags" "opa_default_tags" {}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

data "aws_security_groups" "workato_security_group" {
  filter {
    name   = "group-name"
    values = ["Workato Default Security Group"]
  }

  filter {
    name = "vpc-id"
    values = [data.aws_subnet.selected.vpc_id]
  }
}

data "aws_subnet" "selected" {
  id = var.subnet == "" ? element(
    split(",", local.subnet[lookup(local.subnet, var.vpc_name, "aws-self-service")]),
    length(data.aws_instances.provisioned_instances.ids) % length(split(",", local.subnet[lookup(local.subnet, var.vpc_name, "aws-self-service")]))
  ) : var.subnet
}

data "aws_instances" "provisioned_instances" {
  filter {
    name   = "tag:Provisioning"
    values = ["Terraform"]
  }
}
