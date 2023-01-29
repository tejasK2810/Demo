resource "azurerm_mssql_server" "name" {
    name = var.database_name
    resource_group_name = var.resource_group
    location = var.location
    version = var.database_version
    administrator_login = var.database_admin
    administrator_login_password = var.database_password
}

resource "azurerm_mssql_database" "name" {
    name = "${var.database_name}db"
    server_id = azurerm_mssql_server.name.id
}