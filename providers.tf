terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.21.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.4.3"
    }
    mysql = {
      source  = "petoju/mysql"
      version = "3.0.20"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

provider "mysql" {
  endpoint = "${var.resource_pfx}mariadb.mariadb.database.azure.com:3306"
  username = "${azurerm_mariadb_server.p20cloud.administrator_login}@${var.resource_pfx}mariadb"
  password = azurerm_mariadb_server.p20cloud.administrator_login_password
  tls      = true
}

provider "local" {
  # Configuration options
}