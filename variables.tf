variable "VPC_cidr_block" {
description ="this is for cidr block value"
type=string
}

variable "VPC_NAME"{
description ="this for entering vpc name"
type=string
}
variable "availability_zone"{
description ="this for entering availability zone"
type=string
}
variable "Subnet_cidr_block"{
description ="this for entering public subnet cidr block"
type=string
}
variable "SUbnet_NAME"{
description ="this for entering subnet name"
type=string
}
variable "private_subnet_cidr_block"{
description ="this for entering private subnet cidr block"
type=string
}
variable "Private_SUbnet_NAME"{
description ="this for entering private subnet name"
type=string
}

variable "IGW_NAME"{
description ="this for entering IGW  name"
type=string
}

variable "Routetable_Public_name" {
description ="this for entering Public Route table name"
type=string
}
variable "Routetable_Private_name" {
description ="this for entering private Route table name"
type=string
}
variable "route_cidrblock" {
description ="this for entering Route CIDR BLOCK"
type=string
}
variable "Security_Group_name" {
  description ="this for entering Security group name"
type=string  
}
variable "key_pair_name"{
    description ="this for entering key pair name"
type=string  
}
variable "Keypair_public_key"{
  description ="this for entering key pair public key"
type=string  
}
variable "EC2_AMI_ID"{
  description ="this for entering EC2 instance AMI id"
type=string  
}
variable "EC2_instance_type"{
  description ="this for entering EC2 instance type name"
type=string  
}
variable "EC2_name"{
  description ="this for entering EC2 name"
type=string  
}

 