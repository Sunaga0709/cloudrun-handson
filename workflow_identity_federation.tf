resource "google_iam_workload_identity_pool" "gha" {
  project                   = local.project_id
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions"
  description               = "OIDC Pool for GitHub Actions"

  depends_on = [google_project_service.activate_apis]
}

resource "google_iam_workload_identity_pool_provider" "gha" {
  project                            = local.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.gha.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-actions-pool-provider"
  display_name                       = "GitHub OIDC Provider"
  description                        = "GitHub Actions identity pool provider"
  attribute_mapping = {
    # Google               = 外部トークンクレーム
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }
  attribute_condition = <<EOT
  attribute.repository == "${local.github_repository}" &&
  assertion.ref == "refs/heads/main"
EOT

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}
