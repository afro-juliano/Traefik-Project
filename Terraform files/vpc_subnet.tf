# VPC creation
resource "aws_vpc" "traefik_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    name = "traefik_vpc"
  }
}

# Subnet creation
resource "aws_subnet" "traefik_subnet" {
  vpc_id                  = aws_vpc.traefik_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  depends_on              = [aws_internet_gateway.traefik_igw]
  map_public_ip_on_launch = true

  tags = {
    name = "traefik_subnet"
  }
}
