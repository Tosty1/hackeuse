############################################################
# Resource group
############################################################ 
resource "azurerm_resource_group" "rg" {
  name     = var.resource-group-name
  location = var.resource-group-location
}
############################################################
# plan
############################################################ 
resource "azurerm_service_plan" "plan" {
  name                = var.app-service-plan-name
  location            = var.resource-group-location
  resource_group_name = var.resource-group-name
  os_type             = "Linux"
  sku_name            = "B1" # S1, S2, S3 , P1, P2, P3

  depends_on = [azurerm_resource_group.rg]
}

############################################################
# Azure web app
############################################################ 

resource "azurerm_linux_web_app" "webappbrief13" {
  name                = "webappwordpress${count.index + 1}"
  resource_group_name = var.resource-group-name
  location            = var.resource-group-location
  service_plan_id     = azurerm_service_plan.plan.id
  count               = var.nbress
  site_config {}

  depends_on = [
    azurerm_resource_group.rg, azurerm_service_plan.plan
  ]

 app_settings = {
          
  //DOCKER_REGISTRY_SERVER_URL = "https://hub.docker.com/_/wordpress"

  "DB_NAME" = var.database_config[count.index].DB_NAME,
  "DB_USER" = var.database_config[count.index].DB_USER,
  "DB_PASSWORD" = var.database_config[count.index].DB_PASSWORD

   }  

 }
 
