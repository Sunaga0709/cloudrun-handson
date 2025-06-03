resource "google_service_account" "cloudrun_sa" {
  account_id   = "cloudrun-sa"
  display_name = "CloudRunServiceAccount"

  depends_on = [google_project_service.activate_apis]
}

resource "google_project_iam_member" "cloudrun_artifact_registry_ro" {
  project = local.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
}

resource "google_service_account" "gha" {
  project      = local.project_id
  account_id   = "github-actions-sa"
  display_name = "GitHubActionsServiceAccount"

  depends_on = [google_project_service.activate_apis]
}

resource "google_project_iam_member" "gha_wif" {
  project = local.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${google_service_account.gha.email}"
}

resource "google_project_iam_member" "gha_push_ar" {
  project = local.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.gha.email}"
}
