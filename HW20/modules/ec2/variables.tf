variable "subnet_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "user_data_file" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "list_of_open_ports" {
  type = list(number)
}