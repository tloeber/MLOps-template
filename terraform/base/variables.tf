variable "secret_arn_github_PAT" {
  description = "The ARN of the secret containing the GitHub Personal Access Token"
  type        = string
}
variable "aws_region" {
  description = "AWS region code. (e.g. us-east-1)"
  type        = string
  # Based on https://github.com/databricks/terraform-databricks-sra/
  validation {
    condition = contains(
      ["ap-northeast-1", "ap-northeast-2", "ap-south-1", "ap-southeast-1", "ap-southeast-2", "ca-central-1", "eu-central-1", "eu-west-1", "eu-west-2", "eu-west-3", "sa-east-1", "us-east-1", "us-east-2", "us-west-2"],
      var.aws_region
    )
    error_message = "Valid values for var: region are (ap-northeast-1, ap-northeast-2, ap-south-1, ap-southeast-1, ap-southeast-2, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, sa-east-1, us-east-1, us-east-2, us-west-2)."
  }
}
