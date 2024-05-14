
resource "aws_instance" "opa_instance" {
    ami = var.ami == "NONE"? data.aws_ami.amazon-linux-2.id : var.ami
    instance_type = var.instance_type
    key_name = var.new_cert? aws_key_pair.generated_key[0].key_name : "cs-ops"
    subnet_id   = element(split(",", var.subnet[var.profile]), length(data.aws_instances.provisioned_instances.ids) % 3)
    associate_public_ip_address = true
    vpc_security_group_ids = data.aws_security_groups.workato_security_group.ids

    root_block_device {
      volume_size = var.VOLUME_SIZE
      tags = data.aws_default_tags.opa_default_tags.tags 
    }

    user_data = file("scripts/script.sh")
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

data "aws_instances" "provisioned_instances" {

  filter {
    name   = "tag:Provisioning"
    values = ["Terraform"]
  }
}

data "aws_security_groups" "workato_security_group" {
  filter {
    name   = "group-name"
    values = ["Workato Default Security Group"]
  }
}

