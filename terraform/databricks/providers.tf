# Requires Terraform v0.13 or later
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.38.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
