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
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

provider "tls" {}

