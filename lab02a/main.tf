terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {}

# Task 1: Create Management Group
resource "azurerm_management_group" "az104_mg1" {
  name         = "az104-mg1"
  display_name = "az104-mg1"
}

# Task 2: Create Help Desk group
resource "azuread_group" "helpdesk" {
  display_name     = "Help Desk"
  description      = "Support team with limited VM and ticket permissions"
  security_enabled = true
  mail_enabled     = false
}

# Task 2: Assign built-in role (Virtual Machine Contributor) to Help Desk group
resource "azurerm_role_assignment" "vm_contributor_assignment" {
  scope                = azurerm_management_group.az104_mg1.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azuread_group.helpdesk.object_id
}

# Task 3: Create custom RBAC role for support requests
resource "azurerm_role_definition" "custom_support_request" {
  name        = "Custom Support Request"
  scope       = azurerm_management_group.az104_mg1.id
  description = "A custom contributor role for support requests."

  permissions {
    actions = [
      "Microsoft.Support/*",
      "Microsoft.Compute/*"
    ]
    not_actions = [
      "Microsoft.Support/register/action"
    ]
  }

  assignable_scopes = [
    azurerm_management_group.az104_mg1.id
  ]
}

# Task 3: Assign custom role to Help Desk group
resource "azurerm_role_assignment" "custom_support_assignment" {
  scope              = azurerm_management_group.az104_mg1.id
  role_definition_id = azurerm_role_definition.custom_support_request.role_definition_resource_id
  principal_id       = azuread_group.helpdesk.object_id
}