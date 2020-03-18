variable "cluster_name" {
  default = "engineering"
}

variable "location" {
  default = "europe-west3"
}

variable "node_count" {
  default = 2
}

variable "machine_type" {
  default = "n1-standard-2"
}

variable "k8s_version" {
  default = "1.15.9-gke.22"
}

variable "image_type" {
  default = "UBUNTU"
}
