terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = var.profile
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

provider "tls" {}

