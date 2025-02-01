variable "environment" {}
#Network
variable "public_subnet_id" {
  description = "ID of the public subnet, fetched from modules/vpc/outputs.tf"
  type        = string
}

variable "vpc_jenkins_id" {
  description = "ID of the Jenkins VPC, fetched from modules/vpc/outputs.tf"
  type        = string
}
variable "vpc_cidr" {}
variable "public_subnet_cidr" {}
variable "internet_cidr" {}

#ec2
variable "ec2_instance_type" {}
variable "ami_filter" {}
variable "eip_tag_name" {}

#userdata
variable "jenkins_domain" {}
variable "cert_email" {}