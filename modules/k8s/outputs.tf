output "kubeconfig" {
  value = "${digitalocean_kubernetes_cluster.w3f.kube_config.0.raw_config}"
}
