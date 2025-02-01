# Terraform Infrastructure for Jenkins

## Overview
This Terraform repository provisions the infrastructure required to run a Jenkins server on AWS. It includes an EC2 instance, networking components, and configurations necessary for running Jenkins behind an Nginx reverse proxy. Nginx also gets an SSL certificate from Let's Encrypt.

## Prerequisites
- Terraform installed
- AWS credentials configured
- Existing AMI ID with Jenkins pre-installed
- Existing Elastic IP in AWS
- Domain configured with Elastic IP in Route53

## Usage

### 1. Clone the Repository
```sh
git clone https://github.com/cyse7125-sp25-team03/infra-jenkins
cd infra-jenkins
```

### 2. Initialize Terraform
```sh
terraform init
```

### 3. Customize Configuration
Create a `terraform.tfvars` file (or set variables via environment variables) to match your environment. Refer to variables.tf to see what variables need to be set.

### 4. Apply the Configuration
```sh
terraform apply
```

### 5. Access Jenkins
- You can access Jenkins using the Elastic IP or the domain you have configured. For this project, the domain is `jenkins.csyeteam03.xyz`

## References
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Let's Encrypt](https://letsencrypt.org/)