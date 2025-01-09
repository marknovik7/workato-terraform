terraform {
  backend "azurerm" {
    resource_group_name = "Admin"
    storage_account_name = "marktfstate"
    container_name = "tfstate"
    key = "terraform.tfstate"
    use_azuread_auth = true
    use_oidc = true
    access_key = "9o4mRnqThI2AWB0wNxoVL77i0cQYblevrA7VmEUHoZVoca+q9/v5oypizosk4GBPxya9W6SQBNTC+AStexjYqQ=="
  }
}
