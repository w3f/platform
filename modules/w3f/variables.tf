variable "do_token" {}

variable "node_size" {
  default = "s-4vcpu-8gb"
}

variable "node_count" {
  default = 4
}

variable "k8s_version" {
  default = "1.16.6-do.0"
}

variable "region" {
  default = "fra1"
}
