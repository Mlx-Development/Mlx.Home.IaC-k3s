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
    resource_group_name  = "<<RESOURCE-GROUP-NAME>>"
    storage_account_name = "<<STORAGE-ACCOUNT-NAME>>"
    container_name       = "<<CONTAINER-NAME>>"
    key                  = "<<SOME-IDENTIFIER>>.terraform.tfstate"
  }
}

provider "xenorchestra" {
  insecure = false
}
