provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    "Cost Center" = var.cost_center_tag
  }
}

data "azurerm_policy_definition" "require_tag" {
  display_name = "Require a tag and its value on resources"
}

resource "azurerm_resource_group_policy_assignment" "require_tag_assignment" {
  name                 = "Require Cost Center tag and its value on resources"
  resource_group_id    = azurerm_resource_group.rg.id
  policy_definition_id = data.azurerm_policy_definition.require_tag.id

  parameters = jsonencode({
    tagName = {
      value = "Cost Center"
    }
    tagValue = {
      value = var.cost_center_tag
    }
  })

  description = "Require Cost Center tag and its value on all resources in the resource group"
  enforce     = true
}

data "azurerm_policy_definition" "inherit_tag" {
  display_name = "Inherit a tag from the resource group if missing"
}

resource "azurerm_user_assigned_identity" "policy_identity" {
  name                = "policy-remediation-identity"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_resource_group_policy_assignment" "inherit_tag_assignment" {
  name                 = "Inherit Cost Center tag from RG"
  resource_group_id    = azurerm_resource_group.rg.id
  location             = var.location
  policy_definition_id = data.azurerm_policy_definition.inherit_tag.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.policy_identity.id]
  }

  parameters = jsonencode({
    tagName = {
      value = "Cost Center"
    }
  })

  description = "Inherit Cost Center tag from the resource group if missing"
  enforce     = true
}

resource "azurerm_management_lock" "rg_lock" {
  name       = "rg-lock"
  scope      = azurerm_resource_group.rg.id
  lock_level = "CanNotDelete"
  notes      = "Prevent deletion of resource group"
}