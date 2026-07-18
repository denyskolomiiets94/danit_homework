terraform {
  required_version = ">1.10"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }


  backend "s3" {
    bucket = "tf-state-943865900046"
    region = "eu-central-1"
    key    = "network/network.tfstate"
  }
}

provider "aws" {
  region = var.aws_region
}

variable "instance_type" {
  default = "t3.micro"
}

variable "vpc_id" {
  default = "vpc-03e1d968c6e8bad94"
}
