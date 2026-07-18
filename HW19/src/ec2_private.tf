resource "aws_instance" "private_vm" {
  ami                    = data.aws_ami.ubuntu_26_04.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_b.id
  vpc_security_group_ids = [aws_security_group.my_sg_private.id]
  key_name               = "main-keypair-1"
  tags = {
    Name = "Hello-VM-Private"
  }
}

output "private_vm_ip" {
  value = aws_instance.private_vm.id
}

resource "aws_security_group" "my_sg_private" {
  name        = "tf-sg-private"
  description = "Test"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "tf-sg-private"
  }
}

resource "aws_vpc_security_group_ingress_rule" "private_allow_ssh" {
  security_group_id            = aws_security_group.my_sg_private.id
  referenced_security_group_id = aws_security_group.my_sg_public.id
  from_port                    = 22
  to_port                      = 22
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "private_allow_outbound_all" {
  security_group_id = aws_security_group.my_sg_private.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
