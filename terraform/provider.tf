terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
      version = "~> 0.9"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  # Remove this if not using azure backend
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate927623158"
    container_name       = "tfstate"
    key                  = "dev.k3s.terraform.tfstate"
  }
}

provider "xenorchestra" {
  insecure = true
}
