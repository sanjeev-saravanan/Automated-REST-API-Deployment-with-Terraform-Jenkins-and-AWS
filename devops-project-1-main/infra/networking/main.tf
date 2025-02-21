variable "vpc_cidr" {}
variable "vpc_name" {}
variable "cidr_public_subnet" {}
variable "us_availability_zone" {}
variable "cidr_private_subnet" {}

output "tf_jenkins_proj_vpc_id" {
  value = aws_vpc.tf_jenkins_proj_vpc_us_east_1.id
}

output "tf_jenkins_proj_public_subnets" {
  value = aws_subnet.tf_jenkins_proj_public_subnets.*.id
}

output "public_subnet_cidr_block" {
  value = aws_subnet.tf_jenkins_proj_public_subnets.*.cidr_block
}

# Setup VPC
resource "aws_vpc" "tf_jenkins_proj_vpc_us_east_1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}


# Setup public subnet
resource "aws_subnet" "tf_jenkins_proj_public_subnets" {
  count             = length(var.cidr_public_subnet)
  vpc_id            = aws_vpc.tf_jenkins_proj_vpc_us_east_1.id
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "tf-jenkins-proj-public-subnet-${count.index + 1}"
  }
}

# Setup private subnet
resource "aws_subnet" "tf_jenkins_proj_private_subnets" {
  count             = length(var.cidr_private_subnet)
  vpc_id            = aws_vpc.tf_jenkins_proj_vpc_us_east_1.id
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.us_availability_zone, count.index)

  tags = {
    Name = "tf-jenkins-proj-private-subnet-${count.index + 1}"
  }
}

#Setup Internet Gateway
resource "aws_internet_gateway" "tf_jenkins_proj_public_internet_gateway" {
  vpc_id = aws_vpc.tf_jenkins_proj_vpc_us_east_1.id
  tags = {
    Name = "tf-jenkins-proj-1-igw"
  }
}

# Public Route Table
resource "aws_route_table" "tf_jenkins_proj_public_route_table" {
  vpc_id = aws_vpc.tf_jenkins_proj_vpc_us_east_1.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_jenkins_proj_public_internet_gateway.id
  }
  tags = {
    Name = "tf-jenkins-proj-1-public-rt"
  }
}

# Public Route Table and Public Subnet Association
resource "aws_route_table_association" "tf_jenkins_proj_public_rt_subnet_association" {
  count          = length(aws_subnet.tf_jenkins_proj_public_subnets)
  subnet_id      = aws_subnet.tf_jenkins_proj_public_subnets[count.index].id
  route_table_id = aws_route_table.tf_jenkins_proj_public_route_table.id
}

# Private Route Table
resource "aws_route_table" "tf_jenkins_proj_private_subnets" {
  vpc_id = aws_vpc.tf_jenkins_proj_vpc_us_east_1.id
  #depends_on = [aws_nat_gateway.nat_gateway]
  tags = {
    Name = "tf-jenkins-proj-1-private-rt"
  }
}

# Private Route Table and private Subnet Association
resource "aws_route_table_association" "tf_jenkins_proj_private_rt_subnet_association" {
  count          = length(aws_subnet.tf_jenkins_proj_private_subnets)
  subnet_id      = aws_subnet.tf_jenkins_proj_private_subnets[count.index].id
  route_table_id = aws_route_table.tf_jenkins_proj_private_subnets.id
}