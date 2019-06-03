output "kubeconfig" {
  value = "${digitalocean_kubernetes_cluster.do_cluster.kube_config.0.raw_config}"
  sensitive = true
}
