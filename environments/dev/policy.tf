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
    effect  = { value = "Audit" }
  })
}