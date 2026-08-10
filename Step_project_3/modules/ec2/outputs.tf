output "master_public_ip" {
  value = aws_instance.jenkins_master.public_ip
}

output "master_private_ip" {
  value = aws_instance.jenkins_master.private_ip
}

output "master_instance_id" {
  value = aws_instance.jenkins_master.id
}

output "worker_private_ip" {
  value = aws_instance.jenkins_worker.private_ip
}

output "worker_instance_id" {
  value = aws_instance.jenkins_worker.id
}

output "security_group_id" {
  value = aws_security_group.jenkins.id
}