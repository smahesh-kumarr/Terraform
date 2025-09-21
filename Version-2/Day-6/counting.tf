# count and indexing 
variable "instance_count"{
    description = "count number for the instance"
    type = number
    default = 3
}

resource "aws_instance" "ec2" {
    count = var.instance_count
    ami = "ami-0abc12340abc1234"
    instance_type = "t2.micro"

    tags = {
        Name = "ec2-${count.index}"
        Env = "dev"
    }
}

# output.tf  Indexing and splatting 
output "web_instance_ids" {
  value = aws_instance.web[*].id
}

output "first_private_ip" {
  value = aws_instance.web[0].private_ip
}

# Example Type =2 

variable "names" {
  type = list(string)
  default = ["jenkins", "build", "ansible"]
}

resource "aws_instance" "named" {
  count = length(var.names)
  ami   = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.names[count.index]
  }
}