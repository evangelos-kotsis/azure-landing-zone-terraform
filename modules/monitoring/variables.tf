variable "name" {
  type        = string
  description = "Name of the Log Analytics workspace."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group that holds the workspace."
}

variable "retention_in_days" {
  type        = number
  description = "How many days logs are kept."
  default     = 30
}

variable "daily_quota_gb" {
  type        = number
  description = "Daily ingestion cap in GB. Protects against surprise costs."
  default     = 0.5
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the workspace."
  default     = {}
}