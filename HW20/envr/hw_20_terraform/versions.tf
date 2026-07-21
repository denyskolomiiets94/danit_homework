terraform {
  required_version = ">=1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }


  backend "s3" {
    bucket = "hm-20-terraform-943865900046"
    region = "eu-central-1"
    key    = "denys/hw20/terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}
