terraform {
  backend "azurerm" {
    resource_group_name = "Admin"
    storage_account_name = "marktfstate"
    container_name = "tfstate"
    key = "terraform.tfstate"
    use_azuread_auth = true
    use_oidc = true
  }
}
