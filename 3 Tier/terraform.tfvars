name = "ThreeTierRG"
location = "eastus"
vnetname = "ThreeTierVnet"
vnetcidr = ["10.13.0.0/16"]
subnets = {
      "websubnet" = {
        name = "websubnet"
        address_prefixs = ["10.13.1.0/24"]
      }

      "appsubnet" = {
        name = "appsubnet"
        address_prefixs = ["10.13.2.0/24"]
      } 

      "datasubnet" = {
        name = "datasubnet"
        address_prefixs = ["10.13.3.0/24"]
      } 
    }


database_name = "threetier"
database_version = "12.0"
database_admin = "ThreeTierAdmin"
database_password = "RandomPass"


nsg_rules1 = [ {

    name                       = "WebAllowInInt1"
    priority                   = "101"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "WebAllowInInt2"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.3.0/24"
    destination_address_prefix = "*"
  }
  
  ]

nsg_rules2 = [ {

    name                       = "AppAllowInWeb1"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  },
  {
    name                       = "AppAllowoutweb2"
    priority                   = "101"
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }
  
  ]

nsg_rules3 = [ {

    name                       = "db1"
    priority                   = "101"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "*"
  },
  {
    name                       = "db2"
    priority                   = "102"
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "*"
  }
  
  ]   
