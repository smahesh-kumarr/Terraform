# What are Data Sources?

# Data sources fetch information about existing resources in your cloud account.
# Useful for referencing:
# AMI IDs
# Security Groups
# VPC IDs
# Existing Instances
# They do not create resources, only read details.


# Searching the AMI

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    values = ["*"]
  }
}

# Fetching Existing VPC

data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = data.aws_vpc.default.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}
