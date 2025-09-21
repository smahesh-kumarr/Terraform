# What are Locals?
# Locals are like global variables in Terraform.
# They store expressions or values that are used multiple times in your configuration.
# Purpose: Avoid repetition, simplify maintenance, and make code more readable.

locals {
  common_tags = {
    Environment = "dev"
    Project     = "TerraformDemo"
    CreatedOn   = formatdate("YYYY-MM-DD", timestamp())
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0abc1234"
  instance_type = "t2.micro"

  tags = local.common_tags
}
