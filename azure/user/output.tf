output "user_name" {
  value = azuread_user.new_user.display_name
}

output "object_id" {
  value = azuread_user.new_user.object_id
}

output "user_password" {
  value = azuread_user.new_user.password
  sensitive = true
}