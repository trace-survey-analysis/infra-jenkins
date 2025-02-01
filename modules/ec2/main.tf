data "aws_ami" "ami_jenkins" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = [var.ami_filter]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
data "aws_eip" "eip_jenkins" {
  tags = {
    Name = var.eip_tag_name
  }
}
#NIC
resource "aws_network_interface" "nic_jenkins" {
  subnet_id       = var.public_subnet_id
  security_groups = [aws_security_group.sec_group_jenkins.id]
  tags = {
    Name = "primary_network_interface-${var.environment}"
  }
}
resource "aws_eip_association" "eip_assoc" {
  network_interface_id = aws_network_interface.nic_jenkins.id
  allocation_id        = data.aws_eip.eip_jenkins.id
}
# Security Group
resource "aws_security_group" "sec_group_jenkins" {
  name   = "sec_group_jenkins-${var.environment}"
  vpc_id = var.vpc_jenkins_id

  tags = {
    Name = "sec-group-jenkins-${var.environment}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.sec_group_jenkins.id
  cidr_ipv4         = var.internet_cidr
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sec_group_jenkins.id
  cidr_ipv4         = var.internet_cidr
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.sec_group_jenkins.id
  cidr_ipv4         = var.internet_cidr
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.sec_group_jenkins.id
  cidr_ipv4         = var.internet_cidr
  ip_protocol       = "-1"
}


#EC2
resource "aws_instance" "vm_jenkins" {
  ami           = data.aws_ami.ami_jenkins.id
  instance_type = var.ec2_instance_type
  user_data = base64encode("${templatefile("${path.module}/userdata.sh", {
    SERVER_NAME = "${var.jenkins_domain}"
    CERT_EMAIL  = "${var.cert_email}"
  })}")
  network_interface {
    network_interface_id = aws_network_interface.nic_jenkins.id
    device_index         = 0
  }
  tags = {
    Name = "Jenkins VM"
  }
}

