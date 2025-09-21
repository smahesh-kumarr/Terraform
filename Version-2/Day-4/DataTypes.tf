# simple DataTypes
# string, bool, number Easier to use 


variable "enable_monitoring" {
  description = "Enable CloudWatch monitoring"
  type        = bool
  default     = true
}


# Collection Types
# 1. Set 
# 2. map
# 3. List


# [[[[[
# List 
variable "allowed_ports" {
  description = "List of ports allowed in SG"
  type        = list(number)
  default     = [22, 80, 443]
}


# For List In main.tf

#   from_port       = var.allowed_ports[0]  # 22
#   to_port         = var.allowed_ports[0]

# or Else

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow access to web ports"
  vpc_id      = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = var.allowed_ports    # Loop through each port in the list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
# ]]]]]



# [[[[[
# Set
variable "unique_ips" {
  description = "Set of unique IPs"
  type        = set(string)
  default     = ["10.0.0.1", "10.0.0.2"]
}


resource "aws_security_group" "custom_sg" {
  name   = "custom-sg"
  vpc_id = aws_vpc.my_vpc.id

  dynamic "ingress" {
    for_each = var.unique_ips
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]  # each IP from the set
    }
  }
}
# ]]]]]

# output "max_instance" {
#     value = max(var.instances...)  #same for the min()
# }
# value = replace("web-dev", "dev", "prod") 
# value = upper(var.region)  # "US-EAST-1"
# value = element(var.subnets, 0)  # "subnet-1"
# value = timestamp()
# value = formatdate("YYYY-MM-DD", timestamp())  # 2025-09-20
# user_data = file("scripts/init.sh")


# Sample Example

variable "environment" { default = "dev" }
variable "allowed_ports" { default = [22, 80] }
variable "ami_map" {
  default = {
    dev  = "ami-1234"
    prod = "ami-5678"
  }
}

resource "aws_security_group" "web_sg" {
  ingress {
    from_port   = element(var.allowed_ports, 0)
    to_port     = element(var.allowed_ports, 0)
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_map[var.environment]
  instance_type = var.environment == "prod" ? "t3.medium" : "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  user_data = file("scripts/init.sh")
}
