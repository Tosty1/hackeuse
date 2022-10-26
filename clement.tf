#Storage



resource "azurerm_storage_account" "storage" {
  name                     = "${var.resource_pfx}storage"
  resource_group_name      = var.resource-group-name
  location                 = var.resource-group-location
  account_tier             = "Standard"
  account_replication_type = "LRS"


}


# Création des 20 Blob container
resource "azurerm_storage_container" "container" {
  count                 = "20" # Count Value read from variable
  name                  = "${var.resource_pfx}container${format("%02d", count.index + 1)}"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
  depends_on            = [azurerm_storage_account.storage]
}
/*
# Création du dossier prod dans les 10 blob container (wordpress creer les blobs tout seul )
resource "azurerm_storage_blob" "prod" {
  count = var.container_count
  depends_on             = [azurerm_storage_container.container]
  name                   = "prod/"
  storage_account_name   = var.storage_account_name
  storage_container_name = "${var.container_name_pfx}-${count.index}"
  type                   = "Block"
}

# Création de la clé SAS de chaque container
data "azurerm_storage_account_blob_container_sas" "sas_key_gen" {
  count             = var.container_count
  depends_on        = [azurerm_storage_container.container]
  connection_string = azurerm_storage_account.storage.primary_connection_string
  container_name    = "${var.container_name_pfx}-${count.index}"
  https_only        = true

  start  = "2022-09-26"
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
*/
