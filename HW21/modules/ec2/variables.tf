variable "subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "list_of_open_ports" {
  type = list(string)
}