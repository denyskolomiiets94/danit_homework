variable "env" {
  type = string
  description = "Environment name for name suffix convention "
}

variable "aws_region" {}

variable "vpc_cidr" {}

variable "subnet_cidr" {}

variable "public_subnet_assign_public_ip" {
  default = true
}