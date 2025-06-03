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
