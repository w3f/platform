module "polkadot-k8s" {
  source  = "w3f/polkadot-k8s/azure"
  version = "0.1.2"

  cluster_name = "w3f-china"
  node_count   = 3
  location     = "eastasia"
}
