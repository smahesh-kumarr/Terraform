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
    Name = "MyEIP"
}
}

resource "aws_security_group" "my-demo-sg" {
    name= "demo-sg"
    description = "Allow inbound traffic on port 80"
}

resource "aws_vpc_security_group_ingress_rule" "demo12" {
    security_group_id = aws_security_group.my-demo-sg.id
    cidr_ipv4       = "${aws_eip.lb.public_ip}/32"
    from_port         = 443
    to_port           = 443
    ip_protocol       = "tcp"
    description = "Allow inbound traffic on port 443"
}

output "Elastic-IP" {
    value = aws_eip.lb.public_ip
}

output "Sg-arn" {
    value = aws_security_group.my-demo-sg.arn
}