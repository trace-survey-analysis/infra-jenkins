# Terraform Infrastructure for Jenkins

![Terraform](https://img.shields.io/badge/Terraform-7B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Amazon Web Services](https://img.shields.io/badge/Amazon%20Web%20Services-232F3E.svg?style=for-the-badge&logo=Amazon-Web-Services&logoColor=white)
![Amazon EC2](https://img.shields.io/badge/Amazon_EC2-FF9900.svg?style=for-the-badge&logo=amazon-ec2&logoColor=white)
![Amazon Route 53](https://img.shields.io/badge/Amazon%20Route%2053-8C4FFF.svg?style=for-the-badge&logo=Amazon-Route-53&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939.svg?style=for-the-badge&logo=jenkins&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF.svg?style=for-the-badge&logo=GitHub-Actions&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639.svg?style=for-the-badge&logo=nginx&logoColor=white)
![Let's Encrypt](https://img.shields.io/badge/Let's_Encrypt-003A70.svg?style=for-the-badge&logo=letsencrypt&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420.svg?style=for-the-badge&logo=ubuntu&logoColor=white)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Namecheap](https://img.shields.io/badge/Namecheap-DE3723.svg?style=for-the-badge&logo=Namecheap&logoColor=white)

## Overview

This Terraform repository provisions the infrastructure required to run a Jenkins server on AWS. It includes an EC2 instance, networking components (VPC, subnet, internet gateway), and configurations necessary for running Jenkins behind an Nginx reverse proxy. Nginx also gets an SSL certificate from Let's Encrypt for secure communications.

The infrastructure uses a custom Jenkins AMI that is created using the [ami-jenkins repository](https://github.com/cyse7125-sp25-team03/ami-jenkins.git), which contains Packer templates for building the AMI with Jenkins, Nginx, and other required software pre-installed.

## Architecture

The infrastructure consists of:

- **VPC**: Custom VPC with public subnet
- **Internet Gateway**: For public internet access
- **EC2 Instance**: Hosts Jenkins server and Nginx reverse proxy
- **Security Groups**: Configured for HTTP(S), SSH, and Jenkins ports
- **Elastic IP**: Static IP address associated with the EC2 instance (referenced by tag)
- **Route53 DNS**: Domain configuration for the Jenkins server
- **Let's Encrypt SSL**: Automatic SSL certificate provisioning for HTTPS

## Prerequisites

- Terraform installed locally (v1.0.0+)
- AWS credentials configured locally (`aws configure`)
- Existing AMI ID with Jenkins pre-installed (created from [ami-jenkins repository](https://github.com/cyse7125-sp25-team03/ami-jenkins.git))
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

Create a `terraform.tfvars` file (or set variables via environment variables) to match your environment:

```hcl
# terraform.tfvars example
region      = "us-east-1"
aws_profile = "root"
environment = "dev"

# Network
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"
az_state           = "available"
internet_cidr      = "0.0.0.0/0"

# EC2 Configuration
ec2_instance_type = "t2.micro"
ami_filter        = "jenkins-ami-*"
eip_tag_name      = "Jenkins-EIP"

# Jenkins & SSL Configuration
jenkins_domain = "jenkins.csyeteam03.xyz"
cert_email     = "admin@example.com"
```

Refer to `variables.tf` to see all available configuration options.

### 4. Apply the Configuration

Preview changes with:
```sh
terraform plan
```

Apply the configuration:
```sh
terraform apply
```

### 5. Access Jenkins

- You can access Jenkins using the domain configured in Route53
- Default URL: `https://jenkins.csyeteam03.xyz`
- Initial admin password can be found on the EC2 instance at `/var/lib/jenkins/secrets/initialAdminPassword`

## Security Considerations

- SSH access is restricted to specific IP addresses
- Jenkins is not directly exposed to the internet (behind Nginx)
- HTTPS encryption is enforced with Let's Encrypt certificates
- Security groups are configured with minimal necessary permissions

## References

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Let's Encrypt](https://letsencrypt.org/)
- [Certbot](https://certbot.eff.org/)

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.