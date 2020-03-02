terraform {
  backend "gcs" {
    bucket  = "w3f-security"
    prefix  = "development"
  }
}
