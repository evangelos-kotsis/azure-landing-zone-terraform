variable "name" {
  description = "Key Vault name, globally unique, 3-24 characters"
  type        = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  description = "Entra ID tenant that owns the vault"
  type        = string
}

variable "soft_delete_retention_days" {
  type    = number
  default = 7
}

variable "tags" {
  type    = map(string)
  default = {}
}