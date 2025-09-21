# Lifecycle Hooks 
# It will manage the resource from the actual
#  terraform apply plan destroy cmds 

# 1. create_before_destroy => create the new resource first and 
# later delete the older one 

resource "aws_instance" "app" {
  ami           = "ami-xxxx"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    ignore_changes        = [tags["LastPatched"]]
  }
}

# 2. prevent_destroy => prevent the resource from the accidential deletion 
lifecycle {
  prevent_destroy = true
}

# 3. ignore_changes 
lifecycle {
  ignore_changes = [
    tags["Owner"],
    instance_type
  ]
}

# 4. replace_triggered_by
lifecycle {
  replace_triggered_by = [
    aws_ami.latest.id
  ]
}

# 5.timeouts

lifecycle {
  create_before_destroy = true
}

timeouts {
  create = "20m"
  update = "30m"
  delete = "15m"
}

