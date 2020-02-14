terraform {
  backend "gcs" {
    bucket  = "w3f-tf-state"
    prefix  = "substrate-playground"
  }
}
