resource "azurerm_policy_definition" "require_owner_tag" {
  name         = "require-owner-tag"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Require the owner tag on resources"

  parameters = jsonencode({
    tagName = {
      type = "String"
      metadata = {
        displayName = "Tag name"
      }
      defaultValue = "owner"
    }
    effect = {
      type = "String"
      metadata = {
        displayName = "Effect"
      }
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
    }
  })

  policy_rule = jsonencode({
    if = {
      field  = "[concat('tags[', parameters('tagName'), ']')]"
      exists = "false"
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "require_owner_tag" {
  name                 = "require-owner-tag"
  display_name         = "Require the owner tag on resources"
  policy_definition_id = azurerm_policy_definition.require_owner_tag.id
  subscription_id      = data.azurerm_subscription.current.id

  parameters = jsonencode({
    tagName = { value = "owner" }
    effect  = { value = "Deny" }
  })
}

resource "azurerm_policy_definition" "allowed_locations" {
  name         = "allowed-locations"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "Allow resources only in approved regions"

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"
      metadata = {
        displayName = "Allowed locations"
      }
    }
    effect = {
      type = "String"
      metadata = {
        displayName = "Effect"
      }
      allowedValues = ["Audit", "Deny", "Disabled"]
      defaultValue  = "Audit"
    }
  })

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "location"
          notIn = "[parameters('allowedLocations')]"
        },
        {
          field     = "location"
          notEquals = "global"
        }
      ]
    }
    then = {
      effect = "[parameters('effect')]"
    }
  })
}

resource "azurerm_subscription_policy_assignment" "allowed_locations" {
  name                 = "allowed-locations"
  display_name         = "Allow resources only in approved regions"
  policy_definition_id = azurerm_policy_definition.allowed_locations.id
  subscription_id      = data.azurerm_subscription.current.id

  parameters = jsonencode({
    allowedLocations = { value = [var.location] }
    effect           = { value = "Audit" }
  })
}