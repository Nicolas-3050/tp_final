terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region     = var.region
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "vpc default"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  count         = var.create_instance ? var.instance_number : 0
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.ssh_key
  tags = {
    Name = var.instance_name
  }
}
 

# Create a Security Group
resource "aws_security_group" "allow_ssh_nico-seille" {
   name        = "allows_ssh_nico-seille"
   description = "allows ssh tp nico "

   ingress {
      description = "SSH Port"
      from_port   = var.port-ssh
      to_port     = var.port-ssh
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

    ingress {
      description = "HTTP Port"
      from_port   = var.port-http
      to_port     = var.port-http
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }


   egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
   }
}
