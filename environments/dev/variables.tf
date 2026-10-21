variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "northeurope"
}

variable "environment" {
  description = "Environment short name"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name used in names and tags"
  type        = string
  default     = "azure-landing-zone"
}