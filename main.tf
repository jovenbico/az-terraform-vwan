terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

locals {
  rg-name       = "1-7d435b1f-playground-sandbox"
  prefix-onprem = "onprem"
  prefix-ops    = "ops"
  prefix-spoke1 = "spoke1"
  prefix-spoke2 = "spoke2"

  shared-key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}

data "azurerm_resource_group" "hub-vwan-rg" {
  name = local.rg-name
}

data "azurerm_resource_group" "onprem-vnet-rg" {
  name = local.rg-name
}

data "azurerm_resource_group" "ops-vnet-rg" {
  name = local.rg-name
}

data "azurerm_resource_group" "spoke1-vnet-rg" {
  name = local.rg-name
}

data "azurerm_resource_group" "spoke2-vnet-rg" {
  name = local.rg-name
}