# resource "google_service_account" "cloudrun_sa" {
#   account_id   = "cloudrun-sa"
#   display_name = "CloudRunServiceAccount"
#
#   depends_on = [google_project_service.activate_apis]
# }
#
# resource "google_project_iam_member" "cloudrun_artifact_registry_ro" {
#   project = local.project_id
#   role    = "roles/artifactregistry.reader"
#   member  = "serviceAccount:${google_service_account.cloudrun_sa.email}"
# }

resource "google_service_account" "gha" {
  project      = local.project_id
  account_id   = "github-actions-sa"
  display_name = "GitHubActionsServiceAccount"

  depends_on = [google_project_service.activate_apis]
}

resource "google_service_account_iam_member" "gha_wif" {
  service_account_id = google_service_account.gha.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/projects/${local.project_number}/locations/global/workloadIdentityPools/${google_iam_workload_identity_pool.gha.workload_identity_pool_id}/attribute.repository/${local.github_repository}"
}

resource "google_artifact_registry_repository_iam_member" "gha_writer" {
  project    = local.project_id
  location   = local.region
  repository = google_artifact_registry_repository.image_repo.repository_id
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.gha.email}"
}

resource "google_project_iam_member" "gha_readre" {
  project = local.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gha.email}"
}

resource "google_project_iam_member" "gha_push_ar" {
  project = local.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.gha.email}"
}

resource "google_project_iam_member" "gha_run_admin" {
  project = local.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${google_service_account.gha.email}"
}

resource "google_service_account_iam_member" "gha_act_as_self" {
  service_account_id = google_service_account.gha.name
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.gha.email}"
}
