# Creation mariadb server

resource "azurerm_mariadb_server" "p20cloud" {
  name                = "${var.resource_pfx}mariadb"
  resource_group_name = var.resource-group-name
  location            = var.resource-group-location

  sku_name = "GP_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  administrator_login          = var.admin_login
  administrator_login_password = random_password.dbpassword[0].result
  version                      = "10.2"
  ssl_enforcement_enabled      = false

  depends_on = [azurerm_resource_group.rg, random_password.dbpassword]
}

#######################################################################
# Creation régles firewall

resource "azurerm_mariadb_firewall_rule" "p20cloud" {
  name                = "office_rule"
  resource_group_name = var.resource-group-name
  server_name         = azurerm_mariadb_server.p20cloud.name
  start_ip_address    = data.http.myip.body
  end_ip_address      = data.http.myip.body

  depends_on = [azurerm_mariadb_server.p20cloud]
}

resource "azurerm_mariadb_firewall_rule" "p20cloud2" {
  name                = "allow_access"
  resource_group_name = var.resource-group-name
  server_name         = azurerm_mariadb_server.p20cloud.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"

  depends_on = [azurerm_mariadb_server.p20cloud]
}

#######################################################################
# Creation de base de données mariadbtest

resource "azurerm_mariadb_database" "p20clouddev" {
  name                = "${var.resource_pfx}db${format("%02d", count.index + 1)}"
  resource_group_name = var.resource-group-name
  count               = var.nbress
  server_name         = azurerm_mariadb_server.p20cloud.name
  charset             = "utf8"
  collation           = "utf8_unicode_520_ci"


  depends_on = [azurerm_mariadb_firewall_rule.p20cloud]
}

#######################################################################
# Creation des users du serveur mariadb

resource "mysql_user" "p20clouddev" {
  user               = "${var.resource_pfx}hackeuse${format("%02d", count.index + 1)}"
  host               = "%"
  plaintext_password = random_password.dbpassword[count.index + 1].result
  count              = var.nbress

  depends_on = [azurerm_mariadb_firewall_rule.p20cloud, random_password.dbpassword]
}

#######################################################################
# Ajout des privileges aux users db mariadb

resource "mysql_grant" "p20clouddev" {
  user       = "${var.resource_pfx}hackeuse${format("%02d", count.index + 1)}"
  host       = "%"
  database   = "${var.resource_pfx}db${format("%02d", count.index + 1)}"
  privileges = ["SELECT", "UPDATE", "DELETE", "EXECUTE", "INSERT", "CREATE"]
  # privileges = ["ALL"]
  count      = var.nbress

  depends_on = [mysql_user.p20clouddev, azurerm_mariadb_database.p20clouddev]

# resource "null_resource" "fixgrant" {
#   depends_on = [random_password.dbpassword]
#   triggers = {
#     "always_on" = "${timestamp()}"
#   }
#   # alimentiation du fichier texte avec fixgrant
#   provisioner "local-exec" {
#     command = "echo 'Server name    ${var.resource_pfx}mysql.mysql.database.azure.com\nAdmin-login ${var.admin_login}    Admin-password ${random_string.dbpassword[20].result}    certificat --ssl-ca=BaltimoreCyberTrustRoot.crt.pem' >> fixgrant.sh"
#   }
# }

}

#######################################################################
# Creation des passwords

resource "random_password" "dbpassword" {
  length  = 30
  special = false
  count   = var.nbress + 1
}

#######################################################################
# Export des infos user, db
# parsing des infos à l'aide d'une boucle for et de conditions basées sur l'index du dbpassword
resource "local_sensitive_file" "export" {
  depends_on = [random_password.dbpassword]
  content = yamlencode(
    [for elem in random_password.dbpassword[*].result :
      index(random_password.dbpassword[*].result, elem) == 0 ?
      "server = ${var.resource_pfx}mariadb.mariadb.database.azure.com   admin-login = ${var.admin_login}   admin-pass = ${random_password.dbpassword[0].result}" :
      "login = ${var.resource_pfx}hackeuse${format("%02d", index(random_password.dbpassword[*].result, elem))}   pass = ${elem}   db = ${var.resource_pfx}db${format("%02d", index(random_password.dbpassword[*].result, elem))}"
    ]
  )
  filename = "mariadb.txt"
}

# #export pass pour fixgrant
resource "local_sensitive_file" "export2" {
  content = yamlencode(
    [for elem in random_password.dbpassword[*].result :
      index(random_password.dbpassword[*].result, elem) == 0 ?
      "mysql --user=${var.admin_login} --password=${random_password.dbpassword[0].result} --host=${var.resource_pfx}mariadb.mariadb.database.azure.com":
      "grant SELECT, INSERT, UPDATE, DELETE, CREATE on ${var.resource_pfx}db${format("%02d", index(random_password.dbpassword[*].result, elem))}.* to '${var.resource_pfx}hackeuse${format("%02d", index(random_password.dbpassword[*].result, elem))}'@'%' identified by '${elem}'; *** grant all privileges on ${var.resource_pfx}db${format("%02d", index(random_password.dbpassword[*].result, elem))}.* to '${var.resource_pfx}hackeuse${format("%02d", index(random_password.dbpassword[*].result, elem))}'@'%' identified by '${elem}';  *** flush privileges;"
    ]
  )
  filename = "fixmanos.txt"
}