provider "aws" {
  region = "us-east-1" 
}
resource "aws_instance" "web" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  user_data = <<-EOF
                #!/bin/bash
                apt update -y
                apt install apache2 -y
                systemctl start apache2
                systemctl enable apache2
                echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html
                EOF
  
  tags = {
    Name = "First-Instance",

  }
}
