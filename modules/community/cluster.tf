resource "digitalocean_kubernetes_cluster" "do_cluster" {
  name    = var.name
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = "node-pool"
    size       = var.node_size
    node_count = var.node_count
  }
}
