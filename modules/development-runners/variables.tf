variable "cluster_name" {
  default = "development-runners"
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
