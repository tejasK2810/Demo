output "resource_group" {
    value = azurerm_resource_group.name.name

}

output "location" {
    value = azurerm_resource_group.name.location
}