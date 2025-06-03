resource "google_sql_database_instance" "main" {
  project             = local.project_id
  name                = "main-db"
  region              = local.region
  database_version    = "MYSQL_8_0"
  deletion_protection = false

  settings {
    tier                        = "db-f1-micro"
    pricing_plan                = "PER_USE"
    disk_size                   = 10 # GiB
    disk_type                   = "PD_SSD"
    disk_autoresize             = true # 自動ディスク拡張
    deletion_protection_enabled = false
    edition                     = "ENTERPRISE"
    availability_type           = "ZONAL"
    connector_enforcement       = "NOT_REQUIRED" # Proxy経由を強制
    # data_cache_config {
    #   data_cache_enabled = false
    # }
    # ip_configuration {
    #   private_network = google_compute_network.vpc_network.id
    #   ipv4_enabled    = false # Public IP
    #   ssl_mode        = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
    # }
    # maintenance_window {
    #   day  = 1 # Monday
    #   hour = 4
    # }
    # insights_config {
    #   query_insights_enabled = false
    #   query_string_length    = 1024
    # }
    # password_validation_policy {
    #   enable_password_policy = true
    #   min_length             = 6
    #   reuse_interval         = 5
    # }
  }

  depends_on = [google_project_service.activate_apis]
}

resource "google_sql_user" "dbuser" {
  project  = local.project_id
  name     = "dbuser"
  instance = google_sql_database_instance.main.name
  password = "dbpass"
}

resource "google_sql_database" "maindb" {
  project  = local.project_id
  name     = "maindb"
  instance = google_sql_database_instance.main.name
}
