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
      Name = "KMS Role ${terraform.workspace}"
      OWNER = var.owner
      Due = local.due
      Type = var.type
      Provisioning = "Terraform"
      Jira = "${terraform.workspace}"
    }    
  }  
  profile = var.aws_profile
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

provider "tls" {}

