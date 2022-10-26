resource "azurerm_log_analytics_workspace" "example" {

      for_each = { for user in local.user : user.first_name => user }



  name                = "workspace-test"

  location            = azurerm_resource_group.example.location

  resource_group_name = azurerm_resource_group.example.name

  sku                 = "PerGB2018"

  retention_in_days   = 30

}



resource "azurerm_application_insights" "example" {

        for_each = { for user in local.user : user.first_name => user }



  name                = "tf-test-appinsights"

  location            = azurerm_resource_group.example.location

  resource_group_name = azurerm_resource_group.example.name

  workspace_id        = azurerm_log_analytics_workspace.example.id

  application_type    = "web"

}



output "instrumentation_key" {

  value = azurerm_application_insights.example.instrumentation_key

}



output "app_id" {

  value = azurerm_application_insights.example.app_id