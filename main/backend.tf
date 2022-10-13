terraform {
  backend "gcs" {
    bucket      = "${var.project}-${var.environment}-terraform-states"
  }
}
