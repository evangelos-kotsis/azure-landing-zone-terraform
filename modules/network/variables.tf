variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the network"
  type        = string
}

variable "address_space" {
  description = "Address space of the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet name to its settings"
  type = map(object({
    address_prefixes = list(string)
  }))
}

variable "tags" {
  description = "Tags applied to resources"
  type        = map(string)
  default     = {}
}