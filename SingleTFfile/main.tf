terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.36.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "testRG1"
    storage_account_name = "tejasbackend"
    container_name       = "backendtest"
    key                  = "threetiertest.terraform.tfstate"
  }
}


provider "azurerm" {
    features {
      
    }
}

resource "azurerm_resource_group" "name" {
    name = var.name
    location = var.location
}

resource "azurerm_virtual_network" "name" {
    name = var.vnetname
    resource_group_name = azurerm_resource_group.name.name
    location = var.location
    address_space = var.vnetcidr
}

resource "azurerm_subnet" "name" {
    for_each = var.subnets

    name = each.value["name"]
    virtual_network_name = azurerm_virtual_network.name.name
    resource_group_name = azurerm_resource_group.name.name
    address_prefixes = each.value["address_prefixs"]
}

resource "azurerm_network_interface" "name" {
    
    count = var.numbercount
    name = element(var.nw_int_names, count.index)
    location = var.location
    resource_group_name = azurerm_resource_group.name.name

    ip_configuration {
        
        name = "${element(var.nw_int_names, count.index)}-ip"
        subnet_id = azurerm_subnet.name[element(keys(azurerm_subnet.name),count.index)].id
        //element(azurerm_subnet.name.*.id, count.index)
        //aws_subnet.public[element(keys(aws_subnet.public), 0)].id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_windows_virtual_machine" "example" {
  count = var.numbercount

  name                = element(var.vm_names, count.index)
  resource_group_name = azurerm_resource_group.name.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [ azurerm_network_interface.name[count.index].id ]
  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_network_security_group" "name" {
    count = var.numbercount
    name = "NSG-${count.index}"
    location = var.location
    resource_group_name = azurerm_resource_group.name.name

    dynamic "security_rule" {
      for_each = var.nsg_rules1
      content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }    

}

resource "azurerm_subnet_network_security_group_association" "name" {
  count = var.numbercount
  subnet_id = azurerm_subnet.name[element(keys(azurerm_subnet.name),count.index)].id
  network_security_group_id = azurerm_network_security_group.name[count.index].id 
}
