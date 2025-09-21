# Depends_on 
# If a resource references another resource’s attribute (e.g., subnet_id = aws_subnet.main.id), Terraform knows the subnet must exist first.

# But there are situations where:
# You don’t reference an attribute directly, yet still need a strict order.
# You want to avoid a rare race condition or external dependency.

# Example - I
resource "aws_iam_user" "app_user" {
  name = "app-user"
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = aws_iam_user.app_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"

  depends_on = [
    aws_iam_user.app_user
  ]
}

# Example - II
# Even though the ec2 resource referred the vpc_id or not 
# depends on must ensure that depends resource creates first 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# 1. Simple VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "demo-vpc"
  }
}

# 2. EC2 instance – notice there is NO reference to vpc_id
# (so Terraform cannot auto-infer the dependency)
resource "aws_instance" "demo" {
  ami           = "ami-0c94855ba95c71c99" # example Ubuntu AMI for us-east-1
  instance_type = "t2.micro"

  # explicit dependency
  depends_on = [aws_vpc.main]

  tags = {
    Name = "depends-on-demo"
  }
}
