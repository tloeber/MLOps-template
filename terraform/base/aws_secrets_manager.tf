# For *retrieving* secret
data "aws_secretsmanager_secret_version" "github_PAT_version" {
  # todo: import secret id from central-infra workspace
  secret_id = var.secret_arn_github_PAT
}
