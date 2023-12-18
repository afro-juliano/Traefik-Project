resource "aws_security_group" "traefik_sg" {
  name        = "traefik_sg_in"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    name = "traefik_sg_in"
  }
}
