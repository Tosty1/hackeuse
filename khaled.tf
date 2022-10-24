############################################################
# Resource group
############################################################ 
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
############################################################
# plan
############################################################ 
resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "P1" # S1, S2, S3 , P1, P2, P3

  depends_on = [azurerm_resource_group.rg]
}

############################################################
# Azure web app
############################################################ 

resource "azurerm_linux_web_app" "webappbrief13" {
  name                = "webappwordpress${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  service_plan_id     = azurerm_service_plan.plan.id
  count               = var.webappcount
  site_config {}

  depends_on = [
    azurerm_resource_group.rg, azurerm_service_plan.plan
  ]
}