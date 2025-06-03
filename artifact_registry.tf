resource "google_artifact_registry_repository" "image_repo" {
  location      = local.region
  repository_id = "cloudrun-handson"
  description   = "The repository of cloudrun handson docker"
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}
