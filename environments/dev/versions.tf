terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstate260222066"
    container_name       = "tfstate"
    key                  = "landing-zone/dev.tfstate"
    use_azuread_auth     = true
  }  
}

provider "azurerm" {
  features {}
}