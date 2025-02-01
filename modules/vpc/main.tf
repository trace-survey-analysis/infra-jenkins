#VPC
resource "aws_vpc" "vpc_jenkins" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "vpc-jenkins-${var.environment}"
  }
}

#subnets
data "aws_availability_zones" "available" {
  state = var.az_state
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc_jenkins.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public-subnet-jenkins-${var.environment}"
  }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_jenkins.id

  tags = {
    Name = "igw-${var.environment}"
  }
}

#route table
resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.vpc_jenkins.id

  route {
    cidr_block = var.internet_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-public-subnet-${var.environment}"
  }
}
#rt association
resource "aws_route_table_association" "public-subnet-to-internet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_rt.id
}
