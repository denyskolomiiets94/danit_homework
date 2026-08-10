variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID for Jenkins Master"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet ID for Jenkins Worker"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "master_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for Jenkins Master"
}

variable "worker_instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for Jenkins Worker"
}

variable "list_of_open_ports" {
  type        = list(string)
  description = "TCP ports allowed from the Internet"
}

variable "key_name" {
  type        = string
  description = "AWS EC2 key pair name"
}

variable "public_key" {
  type        = string
  description = "Public SSH key"
}