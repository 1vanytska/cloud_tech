provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    "Lab" = "Lab03-ARM-Bicep"
  }
}

resource "azurerm_managed_disk" "disk1" {
  name                 = var.disk_names[0]
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gib
  tags = {
    "DeployedBy" = "Terraform"
  }
}

resource "azurerm_managed_disk" "disk2" {
  name                 = var.disk_names[1]
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gib
}

resource "azurerm_managed_disk" "disk3" {
  name                 = var.disk_names[2]
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gib
}

resource "azurerm_managed_disk" "disk4" {
  name                 = var.disk_names[3]
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Premium_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gib
}

resource "azurerm_managed_disk" "disk5" {
  name                 = var.disk_names[4]
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gib
  tags = {
    "Template" = "bicep-equivalent"
  }
}