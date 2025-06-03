# 他リソース作成中で使用しないため一旦コメントアウト
# resource "google_cloud_run_v2_service" "app" {
#   name                = "app"
#   location            = local.region
#   ingress             = "INGRESS_TRAFFIC_ALL"
#   deletion_protection = false
#
#   template {
#     service_account = google_service_account.cloudrun_sa.email
#
#     containers {
#       image = "asia-northeast1-docker.pkg.dev/cloudrun-handson-461709/cloudrun-handson/cloudrun-handson:4"
#       resources {
#         limits = {
#           cpu    = "2"
#           memory = "1024Mi"
#         }
#       }
#
#       env {
#         name  = "DB_HOST"
#         value = "10.10.0.3"
#       }
#
#       env {
#         name  = "DB_USER"
#         value = "dbuser"
#       }
#
#       env {
#         name  = "DB_PASSWORD"
#         value = "dbpass"
#       }
#
#       env {
#         name  = "DB_NAME"
#         value = "maindb"
#       }
#     }
#
#     vpc_access {
#       connector = google_vpc_access_connector.vpc_connector.id
#       egress    = "ALL_TRAFFIC"
#     }
#   }
#
#   depends_on = [
#     google_project_service.activate_apis,
#     google_service_account.cloudrun_sa,
#   ]
# }
#
# data "google_iam_policy" "noauth" {
#   binding {
#     role    = "roles/run.invoker"
#     members = ["allUsers"]
#   }
# }
#
# # 全ユーザのアクセス許可
# resource "google_cloud_run_v2_service_iam_policy" "policy" {
#   location    = local.region
#   name        = google_cloud_run_v2_service.app.name
#   policy_data = data.google_iam_policy.noauth.policy_data
# }
