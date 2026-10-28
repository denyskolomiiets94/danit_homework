#
variable "env" {
  type        = string
  description = "Environment name for name suffix convention "
}

variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidr" {
  type = object({
    public_a  = string
    public_b  = string
    private_a = string
    private_b = string
  })
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

