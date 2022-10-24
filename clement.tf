#Storage



resource "azurerm_storage_account" "str" {
  name                = ""
  resource_group_name = azurerm_resource_group.example.name

  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}