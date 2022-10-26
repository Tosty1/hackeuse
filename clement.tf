#Storage



resource "azurerm_storage_account" "storage" {

  depends_on = [azurerm_resource_group.rg]
  name                     = "${var.resource_pfx}storage"
  resource_group_name      = var.resource-group-name
  location                 = var.resource-group-location
  account_tier             = "Standard"
  account_replication_type = "LRS"


}


# Création des 20 container de type "blob"
resource "azurerm_storage_container" "container" {
  count                 = "20" # Count Value read from variable
  name                  = "${var.resource_pfx}container${format("%02d", count.index + 1)}"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.storage]
}


# Création de la clé SAS de chaque container
data "azurerm_storage_account_blob_container_sas" "sas_key_gen" {
  count             = "20"
  depends_on        = [azurerm_storage_container.container]
  connection_string = azurerm_storage_account.storage.primary_connection_string
  container_name    = "${var.resource_pfx}blob${format("%02d", count.index + 1)}"
  https_only        = true

  start  = "2022-10-26"
  expiry = "2022-11-21"

  permissions {
    read   = true
    add    = true
    create = false
    write  = false
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "fr-FR"
  content_type        = "application/json"
}

# Sauvegarde dans un fichier local des clés SAS de nos containers
resource "local_sensitive_file" "cles_sas" {
  content  =  yamlencode(data.azurerm_storage_account_blob_container_sas.sas_key_gen[*])
  filename = "sas_keys.txt"
}

# Backup Storage
/*
resource "azurerm_resource_group" "example" {
  name     = "tfex-network-mapping-primary"
  location = "West Europe"
}
*/

resource "azurerm_recovery_services_vault" "vault" {
  name                = "${var.resource_pfx}vault"
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  sku                 = "Standard"
}

resource "azurerm_storage_account" "backupstr" {
  name                     = "${var.resource_pfx}backupstorage"
  location                 = var.resource-group-location
  resource_group_name      = var.resource-group-name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_backup_container_storage_account" "backupcontainer" {
  resource_group_name = var.resource-group-name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name
  storage_account_id  = azurerm_storage_account.backupstr.id
}