variable "resource_group" {
  
}

variable "location" {
  
}

variable "admin_username" {
  type = string
  default = "admin"
}

variable "admin_password" {
  sensitive = true
}

variable "aset_names" {
  type = list(string)
  default = ["vmaset-demo1","vmaset-demo2","vmaset-demo3"]
}

variable "vm_names" {
  type = list(string)
  default = ["vm-demo1","vm-demo2","vm-demo3"]
}

variable "nw_int_names" {
  type = list(string)
  default = ["nw-int1", "nw-int2","nw-int3"]
}

variable "subnets1" {
  type = any
  default = []
}
 
variable "numbercount" {
    type 	  = number
    default = 3
} 