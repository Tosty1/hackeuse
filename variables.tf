
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


variable "database_config" {
  type = list(object({
    DB_NAME     = string
    DB_USER     = string
    DB_PASSWORD = string

  }))
  default = [
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "",
      DB_USER : "",
      DB_PASSWORD : ""
    },
  ]

}
variable "DB_CHARSET" {
  type    = string
  default = "utf8"

}

variable "DB_HOST" {
  type    = string
  default = ""


}
variable "DB_COLLATE" {
  type    = string
  default = ""

}