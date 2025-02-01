variable "region" {
  description = "VPC region"
  default     = "us-east-1"
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile"
  default     = "dev"
  type        = string
}

variable "environment" {
  description = "Dev or Prod"
  default     = "dev"
  type        = string
}
#vpc module vars
variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = string
}

variable "az_state" {
  description = "Availability state of AZs"
  type        = string
  default     = "available"
}

variable "internet_cidr" {
  description = "CIDR for internet"
  type        = string
  default     = "0.0.0.0/0"
}
#ec2 module vars
variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "ami_filter" {
  description = "AMI Prefix to be filtered across list of AMIs"
  type        = string
}
variable "eip_tag_name" {
  description = "Tag Name of Elastic IP to filter eip"
  type        = string
}
#userdata
variable "cert_email" {
  description = "Email associated with the cert"
  type        = string
}
variable "jenkins_domain" {
  description = "Domain name of jenkins server"
  type        = string
}