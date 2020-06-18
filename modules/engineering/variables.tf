variable "cluster_name" {
  default = "engineering"
}

variable "location" {
  default = "europe-west3"
}

variable "node_count" {
  default = 3
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "k8s_version" {
  default = "1.15.11-gke.3"
}

variable "image_type" {
  default = "UBUNTU"
}
