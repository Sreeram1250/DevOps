data "aws_ami" "my_ami" {
     most_recent      = true     
     owners           = ["721834156908"]
}

resource "aws_instance" "web-1" {
    #ami = "${data.aws_ami.my_ami.id}"
    ami = "ami-020d764f9372da231"
    #count="${var.env=="Prod" ? 3 :1 }"
    count=1
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

resource "null_resource" "nginxinstall" {

    provisioner "remote-exec" {
    
    inline = [
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo service nginx start"

      ]
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file("SREERAM.pem")}"
    host     = "${element(aws_instance.web-1.*.public_ip, 0)}"
    }
    }

}

resource "null_resource" "instancedetails" {
    
    provisioner "local-exec" {
    command = <<EOH
    echo "${element(aws_instance.web-1.*.public_ip, 0)}" >> details.txt && echo "${element(aws_instance.web-1.*.private_ip, 0)}" >> details.txt && echo "${element(aws_instance.web-1.*.public_dns, 0)}" >> details.txt
    EOH
  }
    
    depends_on = ["aws_instance.web-1"]
}
