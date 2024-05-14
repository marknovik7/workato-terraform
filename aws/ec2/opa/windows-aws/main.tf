
resource "aws_instance" "opa_instance" {
    ami = var.ami == "NONE"? data.aws_ami.windows-2022.id : var.ami
    instance_type = var.instance_type
    key_name = var.new_cert? aws_key_pair.generated_key[0].key_name : "cs-ops"
    subnet_id   = var.subnet
    associate_public_ip_address = true
    vpc_security_group_ids = [var.security_group_id]

    root_block_device {
      volume_size = var.VOLUME_SIZE
      tags = data.aws_default_tags.opa_default_tags.tags 
    }

    user_data = <<EOF
      <powershell>
          net user ${var.instance_username} '${random_password.password.result}' /add /y
          net localgroup administrators ${var.instance_username} /add
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

resource "time_static" "date" {
}

resource "tls_private_key" "opa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  count = var.new_cert? 1 : 0
  key_name   = local.name
  public_key = tls_private_key.opa_key.public_key_openssh
}

data "aws_default_tags" "opa_default_tags" {}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

