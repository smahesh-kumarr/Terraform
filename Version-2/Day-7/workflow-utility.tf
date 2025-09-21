# Format all the tf files in the current folder 
terraform fmt

# -target 
/*
Runs and plan on only specific resources because it avoids 
for more api calls to cloud and again and again to check with the 
statefile and current resources 

If ensure no other not changed we can surely used to create others resources 
without make checking with the old resources 
*/

terraform plam -target=aws_resource_type.resource_name
terraform apply -target=aws_resource_type.resource_name


# Resource Replacements 
# If you changed something manually in AWS or need to recreate a resource:
# Terraform plans a destroy + recreate for that instance.

terraform apply -replace="aws_instance.demo"


# Another way to set the replacements in Legacy method 

terraform taint aws_instance.demo
terraform apply
terraform untaint aws_instance.demo


