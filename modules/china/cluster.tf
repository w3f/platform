module "vpc" {
  source  = "alibaba/vpc/alicloud"
  region  = var.region

  create   = true
  vpc_name = "w3f"
  vpc_cidr = var.vpc_cidr

  availability_zones = var.availability_zones
  vswitch_cidrs      = var.vswitch_cidrs

  vpc_tags = {
    Owner       = "w3f"
    Environment = "production"
    Name        = "rpc-nodes"
  }
}

resource "alicloud_cs_kubernetes" "w3f" {
  count                 = 1
  master_vswitch_ids    = module.vpc.this_vswitch_ids
  worker_vswitch_ids    = module.vpc.this_vswitch_ids
  master_instance_types = [var.machine_type,var.machine_type,var.machine_type]
  worker_instance_types = [var.machine_type]
  worker_number         = var.node_count
  install_cloud_monitor = false
  pod_cidr              = var.pod_cidr
  image_id              = var.image_type

  # version can not be defined in variables.tf
  version               = "1.16.6-aliyun.2"
  dynamic "addons" {
      for_each = var.cluster_addons
      content {
        name                    = lookup(addons.value, "name", var.cluster_addons)
        config                  = lookup(addons.value, "config", var.cluster_addons)
      }
  }

  kube_config = var.kube_cli["cfg"]
}
