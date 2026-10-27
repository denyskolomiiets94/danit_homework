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

variable "public_subnet_assign_public_ip" {
  type        = bool
  default     = true
  description = "Whether public subnets assign public IPv4 addresses to launched instances"
}