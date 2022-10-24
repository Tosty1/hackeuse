############################################################
# plan
############################################################ 
resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"

  depends_on = [
    azurerm_application_insights.insight_dev
  ]