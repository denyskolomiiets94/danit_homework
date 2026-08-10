variable "env" {
  type        = string
  description = "Environment name"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "subnet_cidr" {
  type = object({
    public_a  = string
    public_b  = string
    private_a = string
    private_b = string
  })

  description = "Subnet CIDRs"
}

variable "list_of_open_ports" {
  type        = list(string)
  description = "Ports allowed in Security Group"
}

variable "master_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "worker_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "key_name" {
  type        = string
  description = "AWS EC2 key pair name"
}
