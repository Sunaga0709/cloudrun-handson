locals {
  project_id = "cloudrun-handson-461709"
  # tflint-ignore: terraform_unused_declarations
  project_number    = 623372444441
  region            = "asia-northeast1"
  github_repository = "Sunaga0709/cloudrun-handson"

  activate_apis = [
    "compute",
    "vpc_access",
    "service_networking",
    "cloud_sql",
    "cloud_run",
    "iam"
  ]

  gcp_services = {
    resource_manager   = "cloudresourcemanager.googleapis.com"
    compute            = "compute.googleapis.com"
    storage            = "storage.googleapis.com"
    cloud_sql          = "sqladmin.googleapis.com"
    cloud_run          = "run.googleapis.com"
    cloud_functions    = "cloudfunctions.googleapis.com"
    iam                = "iam.googleapis.com"
    secret_manager     = "secretmanager.googleapis.com"
    pubsub             = "pubsub.googleapis.com"
    logging            = "logging.googleapis.com"
    monitoring         = "monitoring.googleapis.com"
    vpc_access         = "vpcaccess.googleapis.com"
    cloud_build        = "cloudbuild.googleapis.com"
    cloud_scheduler    = "cloudscheduler.googleapis.com"
    cloud_trace        = "cloudtrace.googleapis.com"
    bigquery           = "bigquery.googleapis.com"
    cloud_kms          = "cloudkms.googleapis.com"
    firestore          = "firestore.googleapis.com"
    vertex_ai          = "aiplatform.googleapis.com"
    eventarc           = "eventarc.googleapis.com"
    service_networking = "servicenetworking.googleapis.com"
  }
}
