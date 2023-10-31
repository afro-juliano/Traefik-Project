provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-essentials-us-east-1"
    key = "traefik-project.tfstate"
    region = "us-east-1"
  }
}
