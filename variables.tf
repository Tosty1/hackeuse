
#Variables des ressources communes 
variable "nbress" {
  type        = number
  description = "nombre de ressources"
  default     = 20
}
variable "resource-group-name" {
  type    = string
  default = "Brief13wordpress"
}

variable "resource-group-location" {
  type    = string
  default = "northeurope"
}
variable "app-service-plan-name" {
  type    = string
  default = "brief13serviceplan"
}


#variable pour le groupe MariaDB
variable "resource_pfx" {
  type    = string
  default = "b13"
}

variable "admin_login" {
  type    = string
  default = "adminLogin1"
}


locals {
 env_variables = {
   DB_NAME            = ""
   DB_USER       = ""
   DB_PASSWORD       = ""
   DB_HOST = ""
   DB_CHARSET= "utf8"
  DB_COLLATE= ""

 }
 
}
variable "DB_NAME" {
  type = list
  default = ["","","","","","","","","","","","","","","","","","","",""]
  
}
variable "DB_USER" {
  type = list
  default = ["","","","","","","","","","","","","","","","","","","",""]
  
}
variable "DB_PASSWORD" {
  type = list
  default = ["","","","","","","","","","","","","","","","","","","",""]
  
}
variable "DB_HOST" {
  type = string
  default = ""
  
}

