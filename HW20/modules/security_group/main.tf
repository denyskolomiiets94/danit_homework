resource "aws_security_group" "my_sg_public" {
  name        = "tf-sg-public"
  description = "Test"
  vpc_id      = var.vpc_id

  tags = {
    Name = "tf-sg-public"
  }
}

resource "aws_vpc_security_group_ingress_rule" "public_allow_ssh" {
    for_each = {
    for port in var.list_of_open_ports : port => port
  }
  security_group_id = aws_security_group.my_sg_public.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)
  ip_protocol       = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "public_allow_outbound_all" {
  security_group_id = aws_security_group.my_sg_public.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}