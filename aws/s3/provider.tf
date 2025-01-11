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
      DeleteBy = var.end_date
      Type = var.type
      Provisioning = "Terraform"
      Jira = var.jira_ticket_id
      DeleteBy = var.end_date
    }    
  }  
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

provider "tls" {}

