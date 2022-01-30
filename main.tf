terraform {
  cloud {
    organization = "YtseJam"

    workspaces {
      name = "Server-TF"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.72.0"
    }
  }
  required_version = "~> 1.1.3"
}

provider "aws" {
  region = data.terraform_remote_state.network.outputs.aws_region
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = var.tfc_org_name
    workspaces = {
      name = var.tfc_network_workspace_name
    }
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "app" {
  count = var.instance_per_subnet * length(data.terraform_remote_state.network.outputs.private_subnet)

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id              = data.terraform_remote_state.network.outputs.private_subnet[count.index % length(data.terraform_remote_state.network.outputs.private_subnet)]
  vpc_security_group_ids = data.terraform_remote_state.network.outputs.sg_web

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

  tags = {
    Name = "Web"
  }
}

resource "aws_lb_target_group_attachment" "http" {
  count = length(aws_instance.app)

  target_group_arn = data.terraform_remote_state.network.outputs.lb_target_group_http_arn
  target_id        = aws_instance.app.*.index
  port             = 80
}
