
terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.6.0"
    }
  }
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

provider "github" {
  owner = "smahesh-kumarr"
  token = var.github_token
}


resource "github_repository" "example" {
  name        = "sample-repo-by-terraform"
  description = "Repository created the repo by the terraform tf file"
  visibility = "private"
}
