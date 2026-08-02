#
variable "env" {
  type = string
  description = "Environment name for name suffix convention "
}

variable "aws_region" {}

variable "vpc_cidr" {}

variable "subnet_cidr" {}

variable "instance_type" {
  default = "t3.micro"
}

variable "list_of_open_ports" {
  type = list(string)
}