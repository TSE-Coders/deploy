output "ec2_ip" {
  value = aws_instance.instance.private_ip
}
