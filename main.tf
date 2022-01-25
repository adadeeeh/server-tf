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

