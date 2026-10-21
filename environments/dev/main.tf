resource "azurerm_resource_group" "main" {
  name     = "rg-lz-dev"
  location = "westeurope"

  tags = {
    project    = "azure-landing-zone"
    enviroment = "dev"
    managed_by = "terraform"
  }
}