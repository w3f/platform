variable "do_token" {}

variable "name" {
  default = "community"
}

variable "node_size" {
  default = "s-4vcpu-8gb"
}

variable "node_count" {
  default = 4
}

variable "k8s_version" {
  default = "1.19.3-do.2"
}

variable "region" {
  default = "fra1"
}
