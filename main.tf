terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.21.0"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "rg-tfstate"
    storage_account_name = "satfstategh01"
    container_name = "sctfstategh01"
    key = "gh_gmunizc_terraform_actions_test.tfstate"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "rg-test-example-resources"
  location = "eastus2"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "snet-example"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]

  private_endpoint_network_policies_enabled = false
}
