# Create vpc - 10.81.0.0/16
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "prod_vpc_1" {

  cidr_block       = "10.81.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "prod-vpc-1"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "prod_igw_1" {
  vpc_id = aws_vpc.prod_vpc_1.id
  tags = {
    Name = "prod-igw-1"
  }
}

# Create Custom Route Table

resource "aws_route_table" "prod_rt_1" {
  vpc_id = aws_vpc.prod_vpc_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_igw_1.id
  }
  tags = {
    Name = "prod-rt-1"
  }
}

# Create Subnet

resource "aws_subnet" "prod_sub_1" {
  vpc_id     = aws_vpc.prod_vpc_1.id
  cidr_block = "10.81.3.0/24"
  tags = {
    Name = "prod-sub-1"
  }
}

# Associate subnet with route table

resource "aws_route_table_association" "prod_rta_1" {
  subnet_id      = aws_subnet.prod_sub_1.id
  route_table_id = aws_route_table.prod_rt_1.id

}

# Create Security Group

resource "aws_security_group" "prod_sg_1" {
  name        = "prod-web-sg1"
  vpc_id      = aws_vpc.prod_vpc_1.id
  description = "Allow web traffic"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "prod-sg-1"
  }
}


# Create a NIC with an IP with in the subnet

resource "aws_network_interface" "prod_nic_1" {
  subnet_id       = aws_subnet.prod_sub_1.id
  security_groups = [aws_security_group.prod_sg_1.id]
  private_ips     = ["10.81.3.33"]
  tags = {
    Name = "prod-nic-1"
  }
}


# Assign Elastic IP to the NIC

resource "aws_eip" "prod_eip_1" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.prod_nic_1.id
  associate_with_private_ip = "10.81.3.33"
  tags = {
    Name = "prod-eip-1"
  }
  depends_on = [aws_instance.prod_srv_1]
}

# Create EC2 instance

resource "aws_instance" "prod_srv_1" {
  ami           = "ami-0f3caa1cf4417e51b"
  instance_type = "t2.micro"
  key_name      = "Practice_Linux_Key"
  user_data     = file("fb1.sh")
  primary_network_interface {
    network_interface_id = aws_network_interface.prod_nic_1.id
  }
  tags = {
    Name = "prod-srv-1"
  }
}

output "prod_srv_public_ip" {
  value = aws_eip.prod_eip_1.public_ip
}
