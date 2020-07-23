resource "aws_instance" "web-1" {
    ami = "ami-020d764f9372da231"
    count="${var.env=="Prod" ? 3 :1 }"
    availability_zone = "${element(var.azs,count.index)}"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    subnet_id = "${element(aws_subnet.subnets.*.id, count.index)}"
    vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
    associate_public_ip_address = true	
    tags = {
        Name = "${var.env}-Server-${count.index+1}"
        Env = "${var.env}"
        Owner = "Sree"
	    CostCenter = "ABCD"
    }
}