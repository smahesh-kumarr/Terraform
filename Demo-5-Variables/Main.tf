terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  
}

resource "aws_eip" "lb" {
  domain   = "vpc"
    tags = {
        Name = "MYVPC"
    }
}

resource "aws_security_group" "Application-SG" {
    name= "demo-sg"
    description = "Allow inbound traffic on port 80"
}

resource "aws_vpc_security_group_ingress_rule" "HTTP-Port" {
    security_group_id = aws_security_group.Application-SG.id
    cidr_ipv4       = "${aws_eip.lb.public_ip}/32"
    from_port         = var.hTTP-Port
    to_port           = var.hTTP-Port
    ip_protocol       = var.Ip-allow
    description = "Allow inbound traffic on port 80"
}


resource "aws_vpc_security_group_ingress_rule" "SHH-Port" {
    security_group_id = aws_security_group.Application-SG.id
    cidr_ipv4       = "${aws_eip.lb.public_ip}/32"
    from_port         = var.SSH-Port
    to_port           = var.SSH-Port
    ip_protocol       = var.Ip-allow
    description = "Allow inbound traffic on port 22"
}


resource "aws_vpc_security_group_ingress_rule" "FTP-Port" {
    security_group_id = aws_security_group.Application-SG.id
    cidr_ipv4       = "${aws_eip.lb.public_ip}/32"
    from_port         = var.FTP-Port
    to_port           = var.FTP-Port
    ip_protocol       = var.Ip-allow
    description = "Allow inbound traffic on port 21"
}
