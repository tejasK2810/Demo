terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.36.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "testRG1"
    storage_account_name = "tejasbackend"
    container_name       = "backend"
    key                  = "threetier.terraform.tfstate"
  }
}


provider "azurerm" {
    features {
      
    }
}