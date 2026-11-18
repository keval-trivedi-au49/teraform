terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

data "aws_security_group" "app_sg" {
  name        = "ec2_backend_tf_sg"
  description = "Allow SSH, frontend (3000) and backend (5000)"
  vpc_id      = data.aws_subnet.selected.vpc_id
}

resource "aws_instance" "aws_ec2_frontend" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user_data.sh.tftpl", {
    repo_url    = var.repo_url
    repo_branch = var.repo_branch
    mongo_uri   = var.mongo_uri
  })
  user_data_replace_on_change = true

  root_block_device {
    volume_size = 16
  }

  tags = {
    Name = "ec2_backend_tf"
  }
}