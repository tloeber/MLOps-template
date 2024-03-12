# Requires Terraform v0.13 or later
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.0.1"
    }
  }
}

provider "github" {
  # Configuration options
}
