output "public_ips" {
  value = {
    for name, instance in aws_instance.web :
    name => instance.public_ip
  }
}

output "instance_ids" {
  value = {
    for name, instance in aws_instance.web :
    name => instance.id
  }
}

output "security_group_id" {
  value = aws_security_group.my_sg_public.id
}