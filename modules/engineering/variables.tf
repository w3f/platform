variable "cluster_name" {
  default = "engineering"
}

variable "location" {
  default = "europe-west3"
}

variable "node_count" {
  default = 4
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "k8s_version" {
  default = "1.18.12-gke.1200"
}

variable "image_type" {
  default = "UBUNTU"
}
