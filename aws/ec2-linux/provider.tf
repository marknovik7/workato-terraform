terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Name = local.name
      OWNER = var.owner
      Due = local.due
      Type = var.type
      Provisioning = "Terraform"
      Jira = "${terraform.workspace}"
    }    
  }  
  region = var.region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

provider "tls" {}

