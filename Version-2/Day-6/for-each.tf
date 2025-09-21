# For each with the set and map 

resource "aws_s3_buckets" "team_buckets" {
    for_each = toset(["dev", "qa", "devOps"])
    bucket = "my-bucket-${each.value}"
    acl = "private"
}


# Example-II
variable "teams" {
  default = {
    dev = "Developer team bucket"
    prod = "Produciton team bucket"
  }
}
resource "aws_s3_bucket" "team_buckets" {
  for_each = var.teams

  bucket = "my-app-${each.key}"
  tags = {
    Description = each.value
  }
}


