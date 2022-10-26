locals {
csv_data = <<-CSV
first_name
bachelet.celia.1@p20cloud.onmicrosft.com
ayaanhassan92@p20cloud.onmicrosft.com
lylfag@p20cloud.onmicrosft.com
mariebenitah1@p20cloud.onmicrosft.com
yakoubi.yamina3969@p20cloud.onmicrosft.com
cheguettine.deina@p20cloud.onmicrosft.com
amina693@p20cloud.onmicrosft.com
samantha.grobon01@p20cloud.onmicrosft.com
mbacke.mamediarra@p20cloud.onmicrosft.com
cecilia.bellet1@p20cloud.onmicrosft.com
melanie.ferer1@p20cloud.onmicrosft.com
christine.pollaris@p20cloud.onmicrosoft.com
zianielena@p20cloud.onmicrosft.com
juliette.suc@p20cloud.onmicrosft.com
sarah.souchon@p20cloud.onmicrosft.com
cassiekedim2003@p20cloud.onmicrosft.com
meryem0204@p20cloud.onmicrosft.com
Widadwidad2003widad@p20cloud.onmicrosft.com
guemerrima@p20cloud.onmicrosft.com
CSV


  user = csvdecode(local.csv_data)
}

resource "azurerm_dashboard" "dash" {

  for_each = { for user in local.user : user.first_name => user }

  name                = each.value.user
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  dashboard_properties = templatefile("dashboard_hackeuse_Temp.json.tpl", {})

}

output "ids" {
  description = "The ID for all dashboards created"
  value       = { for k, v in azurerm_dashboard.dash : k => v.id }
}


resource "azurerm_log_analytics_workspace" "example" {

      for_each = { for user in local.user : user.first_name => user }



  name                = "workspace-test"

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

  sku                 = "PerGB2018"

  retention_in_days   = 30

  depends_on = [
    ######################## a faire
  ]

}


##################################################################
resource "azurerm_application_insights" "example" {

        for_each = { for user in local.user : user.first_name => user }



  name                = "tf-test-appinsights"

  location            = azurerm_resource_group.rg.location

  resource_group_name = azurerm_resource_group.rg.name

  workspace_id        = azurerm_log_analytics_workspace.example.id

  application_type    = "web"

}



output "instrumentation_key" {

  value = azurerm_application_insights.example.instrumentation_key

}



output "app_id" {

  value = azurerm_application_insights.example.app_id
}