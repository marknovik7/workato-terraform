
resource "aws_instance" "opa_instance" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.new_cert? aws_key_pair.generated_key[0].key_name : "cs-ops" #aws_key_pair.generated_key.key_name
    subnet_id   = var.subnet
    associate_public_ip_address = true

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

