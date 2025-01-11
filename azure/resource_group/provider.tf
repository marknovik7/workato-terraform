terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = ">= 4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    client_id = var.client_id
    use_oidc = true
}