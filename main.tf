# data "aws_ami" "app_ami" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["bitnami-tomcat-*-x86_64-hvm-ebs-nami"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["979382823631"] # Bitnami
# }

# resource "aws_instance" "web" {
#   ami           = data.aws_ami.app_ami.id
#   instance_type = "t3.nano"

#   tags = {
#     Name = "HelloWorld"
#   }
# }

# Animals4Life VPC
resource "aws_vpc" "test-vpc1" {
  cidr_block           = "10.9.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "test-vpc1"
  }
}

resource "aws_internet_gateway" "test-vpc1-igw" {
  vpc_id = aws_vpc.test-vpc1.id
}

output "test_vpc_id" {
  value = aws_vpc.test-vpc1.id
}

# Security Group
resource "aws_security_group" "blog" {
  name        = "blog"
  description = "Allow http and https in. Allow everything out"

  vpc_id = aws_vpc.test-vpc1.id
}