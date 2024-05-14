terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
    #shared_config_files      = ["/Users/federico.oro/.aws/config"]
    #shared_credentials_files = ["/Users/federico.oro/.aws/credentials"]
    profile = var.profile
    default_tags {
        tags = {
        OWNER = var.owner
        Application = var.application
        Provisioning = "Terraform"
        }    
  }  
  region = var.region
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

provider "tls" {}