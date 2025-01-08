# Fetch details of the security groups by name
data "aws_security_groups" "workato_security_group" {
  filter {
    name   = "group-name"
    values = ["Workato Default Security Group"]
  }
}

# Fetch details of a specific security group to get its VPC ID
data "aws_security_group" "selected_security_group" {
  id = data.aws_security_groups.workato_security_group.ids[0]
}

# Fetch subnets in the same VPC as the security group
data "aws_subnets" "self_service_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_security_group.selected_security_group.vpc_id]
  }
  filter {
    name   = "subnet-id"
    values = split(",", local.subnet["aws-self-service"])
  }
}

# Main AWS instance resource
resource "aws_instance" "opa_instance" {
    ami                         = var.ami == "NONE" ? data.aws_ami.amazon-linux-2.id : var.ami
    instance_type               = var.instance_type
    key_name                    = var.new_cert ? aws_key_pair.generated_key[0].key_name : "cs-ops"
    subnet_id                   = try(var.subnet_id, element(data.aws_subnets.self_service_subnets.ids, length(data.aws_instances.provisioned_instances.ids) % length(data.aws_subnets.self_service_subnets.ids)))
    associate_public_ip_address = true
    vpc_security_group_ids      = data.aws_security_groups.workato_security_group.ids

    root_block_device {
      volume_size = var.VOLUME_SIZE
      tags        = data.aws_default_tags.opa_default_tags.tags 
    }

    user_data = file("scripts/script.sh")

    tags = {
      Name = local.name
      Due  = local.due
    }
}

# Static time resource for unique naming
resource "time_static" "date" {}

# Generate a TLS private key if a new certificate is needed
resource "tls_private_key" "opa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS key pair if a new certificate is needed
resource "aws_key_pair" "generated_key" {
  count      = var.new_cert ? 1 : 0
  key_name   = local.name
  public_key = tls_private_key.opa_key.public_key_openssh
}

# Fetch default tags for resources
data "aws_default_tags" "opa_default_tags" {}

# Fetch instances that match the Provisioning tag
data "aws_instances" "provisioned_instances" {
  filter {
    name   = "tag:Provisioning"
    values = ["Terraform"]
  }
}

# Fetch security groups by name
data "aws_security_groups" "workato_security_group" {
  filter {
    name   = "group-name"
    values = ["Workato Default Security Group"]
  }
}