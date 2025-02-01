output "public_subnet_id" {
  value       = aws_subnet.public_subnet.id
  description = "ID of Jenkins public subnet"
}
output "vpc_jenkins_id" {
  value       = aws_vpc.vpc_jenkins.id
  description = "ID of Jenkins VPC"
}

