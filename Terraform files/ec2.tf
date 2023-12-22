data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "instances" {
  count                  = 3
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.traefik_subnet.id
  vpc_security_group_ids = [aws_security_group.traefik_sg.id]
  key_name               = aws_key_pair.kp.key_name

  user_data = <<-EOF
    #!/bin/bash
    exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1
    sudo apt-get update && apt-get upgrade -y
    sudo apt-get install -y docker.io docker-compose
    sudo apt-get install -y ca-certificates curl gnupg
    sudo apt-get install -y kitty
  EOF

  tags = {
    name = "swarm-${count.index}"
  }
}
