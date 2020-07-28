output "aws_id" {
  description = "VPC CIDR Block"
  value       = ["${aws_vpc.default.id}"]
}

output "aws_enable" {
  description = "VPC CIDR Block"
  value       = ["${aws_vpc.default.enable_dns_hostnames}"]
}

#  output "aws_subnet" {
#    description = "Subnets Created for the VPC"
#    value       = ["${aws_subnet.subnets.*.availability_zone}"]
#  }