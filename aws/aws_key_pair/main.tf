resource "time_static" "date" {
}

resource "tls_private_key" "opa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.name
  public_key = tls_private_key.opa_key.public_key_openssh
}

data "aws_default_tags" "opa_default_tags" {}

