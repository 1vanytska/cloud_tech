provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "region1" {
  name     = var.resource_group_region1
  location = var.region1
}

resource "azurerm_resource_group" "region2" {
  name     = var.resource_group_region2
  location = var.region2
}

resource "azurerm_virtual_network" "vnet" {
  name                = "az104-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.region1.location
  resource_group_name = azurerm_resource_group.region1.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.region1.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  name                = "az104-nic"
  location            = azurerm_resource_group.region1.location
  resource_group_name = azurerm_resource_group.region1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.region1.name
  location            = azurerm_resource_group.region1.location
  size                = "Standard_B1ms"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

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

resource "azurerm_recovery_services_vault" "rsv1" {
  name                = var.vault_name_region1
  location            = azurerm_resource_group.region1.location
  resource_group_name = azurerm_resource_group.region1.name
  sku                 = "Standard"
  soft_delete_enabled = true
}

resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = var.backup_policy_name
  resource_group_name = azurerm_resource_group.region1.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv1.name

  timezone = var.timezone

  backup {
    frequency = "Daily"
    time      = "00:00"
  }

  retention_daily {
    count = 7
  }
}

resource "azurerm_storage_account" "diag" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.region1.name
  location                 = azurerm_resource_group.region1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_recovery_services_vault" "rsv2" {
  name                = var.vault_name_region2
  location            = azurerm_resource_group.region2.location
  resource_group_name = azurerm_resource_group.region2.name
  sku                 = "Standard"
  soft_delete_enabled = true
}