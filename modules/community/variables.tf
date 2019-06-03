variable "do_token" {}

variable "node_size" {
  default = "s-4vcpu-8gb"
}

variable "node_count" {
  default = 2
}

variable "k8s_version" {
  default = "1.14.1-do.3"
}

variable "region" {
  default = "fra1"
}
