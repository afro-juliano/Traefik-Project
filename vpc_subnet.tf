# This is the vpc creation
resource "aws_vpc" "traefik_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "traefik_vpc"
  }
}

# These are the parameters for subnet creation
resource "aws_subnet" "traefik_subnet" {
  vpc_id                  = aws_vpc.traefik_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    name = "traefik_subnet"
  }
}

resource "aws_subnet" "traefik_subnet_az1" {
  vpc_id                  = aws_vpc.traefik_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    name = "traefik_subnet_az1"
  }
}

resource "aws_subnet" "traefik_subnet_az2" {
  vpc_id                  = aws_vpc.traefik_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    name = "traefik_subnet_az2"
  }
}
