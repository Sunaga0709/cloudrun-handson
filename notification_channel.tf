resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Allerts"
  type         = "email"
  labels = {
    email_address = "tsunaga0709@gmail.com"
  }
}
