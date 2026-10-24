resource "azurerm_key_vault" "this" {
  #checkov:skip=CKV_AZURE_189: Public access kept for the lab because a private endpoint is billed hourly and the vault is managed from a laptop. Production disables it.
  #checkov:skip=CKV_AZURE_109: Default allow kept for the lab because the laptop IP changes and must not be hardcoded in a public repo. Production sets default_action to Deny.
  #checkov:skip=CKV2_AZURE_32: A private endpoint costs about 7 EUR a month and breaks the lab cost rule. Production uses a private endpoint.

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  rbac_authorization_enabled = true
  purge_protection_enabled   = true
  soft_delete_retention_days = var.soft_delete_retention_days

  tags = var.tags
}