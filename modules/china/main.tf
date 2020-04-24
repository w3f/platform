module "polkadot-k8s" {
  source  = "w3f/polkadot-k8s/azure"
  version = "0.1.1"

  node_count = 3
  location   = "eastasia"
}
