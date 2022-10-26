
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
      DB_NAME : "b13db01",
      DB_USER : "b13hackeuse01",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db02",
      DB_USER : "b13hackeuse02",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db03",
      DB_USER : "b13hackeuse03",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db04",
      DB_USER : "b13hackeuse04",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db05",
      DB_USER : "b13hackeuse05",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db06",
      DB_USER : "b13hackeuse06",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db07",
      DB_USER : "b13hackeuse07",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db08",
      DB_USER : "b13hackeuse08",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db09",
      DB_USER : "b13hackeuse09",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db10",
      DB_USER : "b13hackeuse10",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db11",
      DB_USER : "b13hackeuse11",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db12",
      DB_USER : "b13hackeuse12",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db13",
      DB_USER : "b13hackeuse13",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db14",
      DB_USER : "b13hackeuse14",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db15",
      DB_USER : "b13hackeuse15",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db16",
      DB_USER : "b13hackeuse16",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db17",
      DB_USER : "b13hackeuse17",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db18",
      DB_USER : "b13hackeuse18",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db19",
      DB_USER : "b13hackeuse19",
      DB_PASSWORD : ""
    },
    {
      DB_NAME : "b13db20",
      DB_USER : "b13hackeuse20",
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