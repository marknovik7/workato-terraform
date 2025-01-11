resource "random_password" "user_password" {
  length  = 16
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azuread_user" "new_user" {
    user_principal_name = "cs-infra-${var.new_user}@csdemos.onmicrosoft.com"
    display_name = "cs-infra-${var.new_user}@csdemos.onmicrosoft.com"
    password = random_password.user_password.result
}
