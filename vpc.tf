resource "google_compute_network" "vpc_network" {
  name = "main-network"

  depends_on = [google_project_service.activate_apis]
}

# 設定値を変更してもリソースを更新できないため、1度削除する必要がある
resource "google_vpc_access_connector" "vpc_connector" {
  name           = "vpc-connector"
  ip_cidr_range  = "10.20.0.0/28"
  network        = google_compute_network.vpc_network.id
  min_throughput = 200 # Mbps
  max_throughput = 300 # Mbps

  depends_on = [google_project_service.activate_apis]
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = "10.10.0.0"
  prefix_length = 16
  network       = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]

  depends_on = [google_project_service.activate_apis, google_compute_global_address.private_ip_address]
}
