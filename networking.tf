# Internet VPC
resource "aws_vpc" "demoVpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main"
  }
}

# Subnets
resource "aws_subnet" "demo-main-public-1" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "demo-main-public-2" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "main-public-2"
  }
}

resource "aws_subnet" "demo-main-public-3" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "main-public-3"
  }
}

resource "aws_subnet" "demo-main-private-1" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "demo-main-private-2" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "main-private-2"
  }
}

resource "aws_subnet" "demo-main-private-3" {
  vpc_id                  = aws_vpc.demoVpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "main-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "demo-main-gw" {
  vpc_id = aws_vpc.demoVpc.id

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "demo-main-public" {
  vpc_id = aws_vpc.demoVpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "demo-main-public-1-a" {
  subnet_id      = aws_subnet.demo-main-public-1.id
  route_table_id = aws_route_table.demo-main-public.id
}

resource "aws_route_table_association" "demo-main-public-2-a" {
  subnet_id      = aws_subnet.demo-main-public-2.id
  route_table_id = aws_route_table.demo-main-public.id
}

resource "aws_route_table_association" "demo-main-public-3-a" {
  subnet_id      = aws_subnet.demo-main-public-3.id
  route_table_id = aws_route_table.demo-main-public.id
}

resource "aws_security_group" "demoSg" {
    vpc_id = aws_vpc.demoVpc.id
    description = "SG for Vlan Instances"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "demoSg"
    }
}

resource "aws_security_group" "demo_ELB_SG" {
  vpc_id = aws_vpc.demoVpc.id
  description = "SG for the ELB"
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
      Name = "Vlan-ELB"
  }
}


