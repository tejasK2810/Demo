output "vnetname" {
    value = azurerm_virtual_network.name.name
}

output "websubnet_id" {
    value = {
        for id in keys(var.subnets) : id => azurerm_subnet.name[id].id
    }
}