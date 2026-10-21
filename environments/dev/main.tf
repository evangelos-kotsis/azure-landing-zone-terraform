locals {
  tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  }
}

resource "azurerm_resource_group" "main" {
  name     = "rg-lz-${var.environment}"
  location = var.location

  tags = {
    project     = "azure-landing-zone"
    environment = "dev"
    managed_by  = "terraform"
  }
}