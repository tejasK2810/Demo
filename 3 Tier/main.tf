module "ResourceGroup" {
    source = "./modules/ResourceGroup"
    name = var.name
    location = var.location
}

module "Network" {
    source = "./modules/Network"
    location = module.ResourceGroup.location
    resource_group = module.ResourceGroup.resource_group
    vnetname = var.vnetname
    vnetcidr = var.vnetcidr
    subnets = var.subnets
}



module "Compute" {
    source = "./modules/Compute"
    location = module.ResourceGroup.location
    resource_group = module.ResourceGroup.resource_group
    vm_names = var.vm_names
    nw_int_names = var.nw_int_names
    numbercount = var.numbercount
    subnets1 = module.Network.subnets1
}

module "SecurityGroups" {
    source = "./modules/SecurityGroups"
    location = module.ResourceGroup.location
    resource_group = module.ResourceGroup.resource_group
    nsg_rules1 = var.nsg_rules1
    numbercount = var.numbercount
    subnets1 = module.Network.subnets1
}

module "Database" {
    source = "./modules/Database"
    location = module.ResourceGroup.location
    resource_group = module.ResourceGroup.resource_group
    database_name = var.database_name
    database_version = var.database_version
    database_admin = var.database_admin
    database_password = var.database_password
}