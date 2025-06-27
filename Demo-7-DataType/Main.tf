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

# Variable type = String

# variable "username" {
#   type = string
# }
# resource "aws_iam_user" "lb" {
#   name = var.username
# }

#------------XXXXXX---------------#

# Variable type = number 
# variable "instance_count" {
#   type    = number
#  }

# resource "aws_instance" "example" {
#   count = var.instance_count
#   ami   = "ami-12345678"
#   instance_type = "t2.micro"
# }

#------------XXXXXX-------------#

# Variable type = boolean 

# variable "enable_monitoring" {
#   type    = bool
#   # default = true
# }

# resource "aws_instance" "example" {
#   ami             = "ami-12345678"
#   instance_type   = "t2.micro"
#   monitoring      = var.enable_monitoring
# }

#------------XXXXXX------------#


# Variable Type = list 

# variable "instance_types" {
#   type    = list(string)
#   default = ["t2.micro", "t3.small", "t3.medium"]
# }

# resource "aws_instance" "example" {
#   instance_type = var.instance_types[0]
#   ami           = "ami-12345678"
# }

#------------XXXXXX--------------#

# Variable Type = Map
# variable "instance_amis" {
#   type = map(string)
#   default = {
#     "us-east-1" = "ami-0c614dee691cbbf37"
#     "us-east-2" = "ami-018875e7376831abe"
#   }
# }

# resource "aws_instance" "example" {
#   ami           = var.instance_amis["us-east-2"]
#   instance_type = "t2.micro"
# }
#------------XXXXXX--------------#


# Conditional
variable "environment" {
  type    = string
  default = "prod"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = var.environment == "prod" ? "t3.large" : "t2.micro"
}
