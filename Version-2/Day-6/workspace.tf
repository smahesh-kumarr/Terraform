# Workspace
# Terraform code but maintain multiple independent state files—perfect
#  for isolating environments such as dev, staging, and prod without copying 
# or branching your configuration.

# Commands to manage the workspace 
terraform workspace list 
terraform workspace new dev
terraform workspace select dev
terraform workspace show
terraform workspace delete dev


variable "instance_type_map" {
  type = map(string)
  default = {
    default = "t3.micro"
    dev     = "t3.small"
    prod    = "t3.large"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-xxxx"
  instance_type = lookup(var.instance_type_map, terraform.workspace, var.instance_type_map["default"])

  tags = {
    Name = "web-${terraform.workspace}"
  }
}

