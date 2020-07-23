variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "amis" {}
#       description = "AMIs by region"
#       type = "list"
#       default = {
#           ap-southeast-2 = "ami-020d764f9372da231" 
#       }
# }


variable "vpc_cidr" {}
variable "vpc_name" {}
variable "security_group" {}
variable "IGW_name" {}
variable "key_name" {}

variable "public_subnet1_name" {}
variable "public_subnet2_name" {}
variable "public_subnet3_name" {}
variable "env" {}

variable Main_Routing_Table {}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = "list"
  default = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
}

variable "cidrs" {
  description = "CIDR blocks for subnets"
  type = "list"
  default = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
variable "instance_type" {
  type = "map"
  default = {   
    test = "t2.micro"    
    }
}