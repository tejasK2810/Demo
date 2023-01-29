resource "azurerm_virtual_network" "name" {
    name = var.vnetname
    resource_group_name = var.resource_group
    location = var.location
    address_space = var.vnetcidr
}

resource "azurerm_subnet" "name" {
    for_each = var.subnets

    name = each.value["name"]
    virtual_network_name = azurerm_virtual_network.name.name
    resource_group_name = var.resource_group
    address_prefixes = each.value["address_prefixs"]
}

resource "azurerm_public_ip" "name" {

    name                = "${var.bastionhost_name}PubIp"
    resource_group_name = var.resource_group
    location            = var.location
    allocation_method   = "Static"    
    sku                 = "Standard"
}


resource "azurerm_bastion_host" "example" {
  name                = var.bastionhost_name
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.name.["bastion_subnet"].id
    public_ip_address_id = azurerm_public_ip.name.id
  }
}
