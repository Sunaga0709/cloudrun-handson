# 他リソース作成中で使用しないため一旦コメントアウト
resource "google_cloud_run_v2_service" "app" {
  name                = "app"
  location            = local.region
  ingress             = "INGRESS_TRAFFIC_ALL"
  deletion_protection = false

  template {
    service_account = google_service_account.gha.email

    containers {
      image = "gcr.io/cloudrun/hello" # CI/CDにてイメージ指定、デプロイを行うので仮のイメージを設定
      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }

    vpc_access {
      connector = google_vpc_access_connector.vpc_connector.id
      egress    = "ALL_TRAFFIC"
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image
    ]
  }

  depends_on = [
    google_project_service.activate_apis,
    google_service_account.gha,
  ]
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

# 全ユーザのアクセス許可
resource "google_cloud_run_v2_service_iam_policy" "policy" {
  location    = local.region
  name        = google_cloud_run_v2_service.app.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
