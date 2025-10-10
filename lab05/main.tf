provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "lab_rg" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "core_vnet" {
  name                = var.core_vnet_name
  address_space       = [var.core_vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_subnet" "core_subnet" {
  name                 = var.core_subnet_name
  resource_group_name  = azurerm_resource_group.lab_rg.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = [var.core_subnet_prefix]
}

resource "azurerm_network_interface" "core_nic" {
  name                = "CoreServicesNIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.core_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "core_vm" {
  name                = var.core_vm_name
  resource_group_name = azurerm_resource_group.lab_rg.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.core_nic.id]
  provision_vm_agent  = true
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_network" "manufacturing_vnet" {
  name                = var.manufacturing_vnet_name
  address_space       = [var.manufacturing_vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_subnet" "manufacturing_subnet" {
  name                 = var.manufacturing_subnet_name
  resource_group_name  = azurerm_resource_group.lab_rg.name
  virtual_network_name = azurerm_virtual_network.manufacturing_vnet.name
  address_prefixes     = [var.manufacturing_subnet_prefix]
}

resource "azurerm_network_interface" "manufacturing_nic" {
  name                = "ManufacturingNIC"
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.manufacturing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "manufacturing_vm" {
  name                = var.manufacturing_vm_name
  resource_group_name = azurerm_resource_group.lab_rg.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [azurerm_network_interface.manufacturing_nic.id]
  provision_vm_agent  = true
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_virtual_network_peering" "core_to_manufacturing" {
  name                      = "CoreServicesVnet-to-ManufacturingVnet"
  resource_group_name       = azurerm_resource_group.lab_rg.name
  virtual_network_name      = azurerm_virtual_network.core_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.manufacturing_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "manufacturing_to_core" {
  name                      = "ManufacturingVnet-to-CoreServicesVnet"
  resource_group_name       = azurerm_resource_group.lab_rg.name
  virtual_network_name      = azurerm_virtual_network.manufacturing_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.core_vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_subnet" "perimeter_subnet" {
  name                 = var.perimeter_subnet_name
  resource_group_name  = azurerm_resource_group.lab_rg.name
  virtual_network_name = azurerm_virtual_network.core_vnet.name
  address_prefixes     = [var.perimeter_subnet_prefix]
}

resource "azurerm_route_table" "core_route_table" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = azurerm_resource_group.lab_rg.name
}

resource "azurerm_route" "perimeter_to_core" {
  name                   = var.route_name
  resource_group_name    = azurerm_resource_group.lab_rg.name
  route_table_name       = azurerm_route_table.core_route_table.name
  address_prefix         = var.core_vnet_address_space
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.nva_ip
}

resource "azurerm_subnet_route_table_association" "core_subnet_route" {
  subnet_id      = azurerm_subnet.core_subnet.id
  route_table_id = azurerm_route_table.core_route_table.id
}