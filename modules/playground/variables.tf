variable "cluster_name" {
  default = "playground"
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "b"
}

variable "min_node_count" {
  default = 3
}

variable "k8s_version" {
  default = "1.15.11-gke.9"
}

variable "max_node_count" {
  default = 6
}

variable "machine_type" {
  default = "n1-standard-4"
}

variable "image_type" {
  default = "UBUNTU"
}
