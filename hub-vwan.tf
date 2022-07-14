# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

resource "azurerm_virtual_wan" "main-vwan" {
  name                = "main-vwan"
  resource_group_name = data.azurerm_resource_group.hub-vwan-rg.name
  location            = data.azurerm_resource_group.hub-vwan-rg.location
}

resource "azurerm_virtual_hub" "main-vwan-hub" {
  name                = "main-vwan-hub"
  resource_group_name = data.azurerm_resource_group.hub-vwan-rg.name
  location            = data.azurerm_resource_group.hub-vwan-rg.location
  virtual_wan_id      = azurerm_virtual_wan.main-vwan.id
  address_prefix      = "10.99.0.0/16"

  timeouts {
    create = "60m"
  }
}