# Generic variables for Azure subscription

variable "subscription_id" {
  type = string
  sensitive = true
}

variable "tenant_id" {
  type = string
  sensitive = true
}

variable "client_id" {
  type = string
  sensitive = true
}

variable "resource_group_name" {
    type = string
    description = "specify resource group name"
}

variable "location" {
    type = string
    description = "specify resource region"
    default = "eastus"
}

variable "resource_tags" {
  description = "Tags to set for all resources"
  type = map(string)
}