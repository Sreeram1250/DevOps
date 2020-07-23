provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}


terraform {
  backend "s3" {
    bucket = "sreeraminfytest"
    key    = "terraform/tfstatefiles"
    region = "ap-southeast-2"
  }
}
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.env}-VPC"
	    Owner = "Sree"
        CostCenter=8080
        Env="Prod"
    }
}

resource "aws_subnet" "subnets" {
    count = "${length(var.cidrs)}"
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${element(var.cidrs,count.index)}"
    availability_zone = "${element(var.azs,count.index)}"
    tags = {
        Name = "${var.vpc_name}-Subnet-${count.index+1}"
    }
}


resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags = {
        Name = "${var.IGW_name}"
    }
}

resource "aws_route_table" "private" {   
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}

resource "aws_route_table_association" "private" {
    count = "${length(var.cidrs)}"
    subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
    route_table_id = "${aws_route_table.private.id}"
 }


resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }
     tags = {
        Name = "${var.security_group}"
    }
}