# Internet Gateway
resource "aws_internet_gateway" "traefik_igw" {
  vpc_id = aws_vpc.traefik_vpc.id

  tags = {
    name = "Internet Gateway Traefik"
  }
}

# Route
resource "aws_route_table" "traefik_route_table" {
  vpc_id = aws_vpc.traefik_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.traefik_igw.id
  }

  tags = {
    name = "Route Traefik"
  }
}
# Route association
resource "aws_route_table_association" "traefik_association" {
  subnet_id      = aws_subnet.traefik_subnet.id
  route_table_id = aws_route_table.traefik_route_table.id
}
