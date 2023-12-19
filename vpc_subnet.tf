# This is the vpc creation
resource "aws_vpc" "traefik_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

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

resource "aws_network_acl" "traefik_acl" {
  vpc_id = aws_vpc.traefik_vpc.id

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  subnet_ids = [aws_subnet.traefik_subnet.id]

  tags = {
    Name = "traefik_acl"
  }
}

resource "aws_internet_gateway" "traefik_igw" {
  vpc_id = aws_vpc.traefik_vpc.id
}

resource "aws_route_table" "traefik_route_table" {
  vpc_id = aws_vpc.traefik_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.traefik_igw.id
  }
}

resource "aws_route_table_association" "traefik_association" {
  subnet_id      = aws_subnet.traefik_subnet.id
  route_table_id = aws_route_table.traefik_route_table.id
}
