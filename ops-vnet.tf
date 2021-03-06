
resource "azurerm_virtual_network" "ops-vnet" {
  name                = "${local.prefix-ops}-vnet"
  location            = data.azurerm_resource_group.ops-vnet-rg.location
  resource_group_name = data.azurerm_resource_group.ops-vnet-rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "ops-spoke"
  }
}

resource "azurerm_subnet" "ops-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = data.azurerm_resource_group.ops-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.ops-vnet.name
  address_prefixes     = ["10.0.255.224/27"]
}

resource "azurerm_subnet" "ops-mgmt" {
  name                 = "mgmt"
  resource_group_name  = data.azurerm_resource_group.ops-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.ops-vnet.name
  address_prefixes     = ["10.0.0.64/27"]
}

resource "azurerm_subnet" "ops-dmz" {
  name                 = "dmz"
  resource_group_name  = data.azurerm_resource_group.ops-vnet-rg.name
  virtual_network_name = azurerm_virtual_network.ops-vnet.name
  address_prefixes     = ["10.0.0.32/27"]
}

# resource "azurerm_network_interface" "hub-nic" {
#   name                 = "${local.prefix-hub}-nic"
#   location             = data.azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name  = data.azurerm_resource_group.hub-vnet-rg.name
#   enable_ip_forwarding = true

#   ip_configuration {
#     name                          = local.prefix-hub
#     subnet_id                     = azurerm_subnet.hub-mgmt.id
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = {
#     environment = local.prefix-hub
#   }
# }

# #Virtual Machine
# resource "azurerm_virtual_machine" "hub-vm" {
#   name                  = "${local.prefix-hub}-vm"
#   location              = data.azurerm_resource_group.hub-vnet-rg.location
#   resource_group_name   = data.azurerm_resource_group.hub-vnet-rg.name
#   network_interface_ids = [azurerm_network_interface.hub-nic.id]
#   vm_size               = var.vmsize

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "16.04-LTS"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name              = "${local.prefix-hub}-myosdisk1"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = "${local.prefix-hub}-vm"
#     admin_username = var.username
#     admin_password = var.password
#   }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }

#   tags = {
#     environment = local.prefix-hub
#   }
# }

resource "azurerm_virtual_hub_connection" "ops-vhub-conn" {
  name                      = "ops-vhub-conn"
  virtual_hub_id            = azurerm_virtual_hub.main-vwan-hub.id
  remote_virtual_network_id = azurerm_virtual_network.ops-vnet.id

  depends_on = [
    azurerm_virtual_hub.main-vwan-hub,
    azurerm_virtual_network.ops-vnet
  ]
}