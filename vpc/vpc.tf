

resource "aws_vpc" "nginx-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "nginx-subnet-1" {
  availability_zone = var.avail_zone
  cidr_block        = var.subnet_cidr_block
  vpc_id            = aws_vpc.nginx-vpc.id
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nginx-vpc.id
  tags = {
    Name = "${var.env_prefix}-igw"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.nginx-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env_prefix}-rtb"
  }
}
resource "aws_route_table_association" "rtb-subnet-1" {
  subnet_id = aws_subnet.nginx-subnet-1.id
  route_table_id = aws_route_table.rtb.id
}

