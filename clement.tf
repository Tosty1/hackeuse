#Storage



resource "azurerm_storage_account" "str" {
  name                = "${var.resource_pfx}storage"
  resource_group_name = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  
}

resource "azurerm_storage_container" "example" {
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.str.name
  container_access_type = "private"
}