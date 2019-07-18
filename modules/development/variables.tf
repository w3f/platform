variable "cluster_name" {
  default = "development"
}

variable "location" {
  default = "europe-west6-a"
}

variable "node_count" {
  default = 3
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "k8s_version" {
  default = "1.13.6-gke.13"
}
