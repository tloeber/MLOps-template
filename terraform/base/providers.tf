# Requires Terraform v0.13 or later
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.0.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "github" {
  # owner = var.github_organization
  token = data.aws_secretsmanager_secret_version.github_PAT_version.secret_string
}
