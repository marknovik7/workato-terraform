resource "azurerm_resource_group" "res_grp" {
  name = var.resource_group_name
  location = var.location
  tags = var.resource_tags
}
