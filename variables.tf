
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


