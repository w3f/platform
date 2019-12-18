variable "cluster_name" {
  default = "development"
}

variable "location" {
  default = "europe-west4"
}

variable "runner_node_count" {
  default = 1
}

variable "runner_machine_type" {
  default = "n1-standard-4"
}

variable "k8s_version" {
  default = "1.13.6-gke.13"
}
