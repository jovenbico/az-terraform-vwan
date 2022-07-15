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

resource "azurerm_firewall" "main-vwan-hub-firewall" {
  name                = "main-vwan-hub-firewall"
  resource_group_name = data.azurerm_resource_group.hub-vwan-rg.name
  location            = data.azurerm_resource_group.hub-vwan-rg.location
  sku_name            = "AZFW_Hub"
  sku_tier            = "Standard"

  threat_intel_mode = ""
  virtual_hub {
    public_ip_count = 1
    virtual_hub_id  = azurerm_virtual_hub.main-vwan-hub.id
  }

  depends_on = [
    azurerm_virtual_hub.main-vwan-hub
  ]
}