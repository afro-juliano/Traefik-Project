# Enable vpc endpoint
resource "aws_vpc_endpoint" "traefik_vpc_endpoint" {
  vpc_id       = aws_vpc.traefik_vpc.id
  service_name = "com.amazonaws.us-east-1.s3"

  tags = {
    environment = "Vpc endpoint"
  }
}

