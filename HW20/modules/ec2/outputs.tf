output "public_ip" {
  value = aws_instance.public_vm.public_ip
}

output "security_group_id" {
  value = aws_security_group.my_sg_public.id
}