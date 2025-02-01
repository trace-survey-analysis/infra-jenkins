module "vpc" {
  source             = "./modules/vpc"
  environment        = var.environment
  internet_cidr      = var.internet_cidr
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  az_state           = var.az_state
}
module "ec2" {
  source             = "./modules/ec2"
  ec2_instance_type  = var.ec2_instance_type
  ami_filter         = var.ami_filter
  eip_tag_name       = var.eip_tag_name
  public_subnet_id   = module.vpc.public_subnet_id
  vpc_jenkins_id     = module.vpc.vpc_jenkins_id
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  internet_cidr      = var.internet_cidr
  environment        = var.environment
  jenkins_domain     = var.jenkins_domain
  cert_email         = var.cert_email
}