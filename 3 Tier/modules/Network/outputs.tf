output "vnetname" {
    value = azurerm_virtual_network.name.name
}

output "subnets1" {
    value = {
        for id in keys(var.subnets) : id => azurerm_subnet.name[id].id
    }
}



