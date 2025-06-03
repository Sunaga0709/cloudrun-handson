terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.37.0"
    }
  }

  # backend "gcs" {
  #   bucket = ""
  #   prefix = ""
  # }
}

provider "google" {
  project     = local.project_id
  region      = local.region
  credentials = file("./credentials/terraform-sa.json") # Terraformで使用するクレデンシャル
}
