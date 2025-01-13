output "resource_group_name" {
  value = azurerm_resource_group.res_grp.name
}

output "resource_group_location" {
  value = azurerm_resource_group.res_grp.location
}

output "resource_group_tags" {
  value = azurerm_resource_group.res_grp.resource_tags
}

output "resource_group_id" {
  value = azurerm_resource_group.res_grp.id
}