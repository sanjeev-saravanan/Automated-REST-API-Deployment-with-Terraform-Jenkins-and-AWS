variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "us2_availability_zone" {}
variable "cidr_private_subnet" {}

output "jenkins_proj_1_vpc_id" {
  value = aws_vpc.tf_jenkins_proj_vpc_us_east_2.id
}

output "tf_jenkins_proj_1_public_subnets" {
  value = aws_subnet.jenkins_proj_1_public_subnets.*.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.jenkins_proj_1_public_subnets.*.cidr_block
}

# Setup VPC
resource "aws_vpc" "tf_jenkins_proj_vpc_us_east_2" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}


# Setup public subnet
resource "aws_subnet" "jenkins_proj_1_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.tf_jenkins_proj_vpc_us_east_2.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us2_availability_zone, count.index)

  tags = {
    Name = "jenkins-proj-public-subnet-${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "jenkins_proj_1_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.tf_jenkins_proj_vpc_us_east_2.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us2_availability_zone, count.index)

  tags = {
    Name = "jenkins-proj-private-subnet-${count.index + 1}"
  }
}

# Setup Internet Gateway
resource "aws_internet_gateway" "jenkins_proj_1_public_internet_gateway" {
  vpc_id = aws_vpc.tf_jenkins_proj_vpc_us_east_2.id
  tags = {
    Name = "jenkins-proj-1-igw"
  }
}

# Public Route Table
resource "aws_route_table" "jenkins_proj_1_public_route_table" {
  vpc_id = aws_vpc.tf_jenkins_proj_vpc_us_east_2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_proj_1_public_internet_gateway.id
  }
  tags = {
    Name = "jenkins-proj-1-public-rt"
  }
}

resource "aws_route_table_association" "jenkins_proj_1_public_subnet_association" {
  count = length(var.cidr_public_subnet)
  subnet_id = element(aws_subnet.jenkins_proj_1_public_subnets.*.id, count.index)
  route_table_id = aws_route_table.jenkins_proj_1_public_route_table.id
}

# Private Route Table
resource "aws_route_table" "jenkins_proj_1_private_route_table" {
  vpc_id = aws_vpc.tf_jenkins_proj_vpc_us_east_2.id
  #depends_on = [aws_nat_gateway.nat_gateway]
  tags = {
    Name = "jenkins-proj-1-private-rt"
  }
}

resource "aws_route_table_association" "jenkins_proj_1_private_subnet_association" {
  count          = length(var.cidr_private_subnet)
  subnet_id      = element(aws_subnet.jenkins_proj_1_private_subnets.*.id, count.index)
  route_table_id = aws_route_table.jenkins_proj_1_private_route_table.id
}