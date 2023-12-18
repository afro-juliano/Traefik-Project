//resource "tls_private_key" "pk" {
//  algorithm = "RSA"
//  rsa_bits = 4096
//}

resource "aws_key_pair" "kp" {
  key_name = "traefik_key"
  public_key = file("${path.module}/traefik_key.pub")

//  provisioner "local-exec" {
//  command = "echo '${tls_private_key.pk.private_key_pem}' > ./traefik_key.pem"
//  }
}
