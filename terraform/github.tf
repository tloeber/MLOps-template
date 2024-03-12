resource "github_repository" "project_repo" {
  name        = "MLOps-template"
  description = "Template repo for MLOps projects"
  visibility  = "public"

  has_discussions = true
  has_projects    = true
  has_issues      = true
  has_wiki        = true

  is_template        = true
  archive_on_destroy = true

  # Branch rules
  delete_branch_on_merge = true

  # Security
  # -------
  vulnerability_alerts = true
  # Don't call the vulnerability alerts endpoint during read, so the resource can also be used without admin permissions
  ignore_vulnerability_alerts_during_read = true
  security_and_analysis {
    advanced_security {
      # Enable advanced security features
      status = "enabled"
    }
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}
