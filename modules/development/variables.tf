variable "cluster_name" {
  default = "development"
}

variable "location" {
  default = "europe-west4"
}

variable "node_count" {
  default = 4
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "k8s_version" {
  default = "1.16.9-gke.6"
}

variable "image_type" {
  default = "UBUNTU"
}
