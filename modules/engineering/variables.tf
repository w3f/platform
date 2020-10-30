variable "cluster_name" {
  default = "engineering"
}

variable "location" {
  default = "europe-west3"
}

variable "node_count" {
  default = 5
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "k8s_version" {
  default = "1.16.13-gke.401"
}

variable "image_type" {
  default = "UBUNTU"
}
