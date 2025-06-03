resource "google_project_service" "activate_apis" {
  for_each = {
    for svc in local.activate_apis : svc => local.gcp_services[svc]
  }

  project                    = local.project_id
  service                    = each.value
  disable_dependent_services = true
}
