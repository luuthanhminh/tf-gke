provider "google" {
  credentials = file("${var.environment}.json")
}

provider "google-beta" {
  credentials = file("${var.environment}.json")
}
