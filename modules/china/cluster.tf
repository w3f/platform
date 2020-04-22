resource "alicloud_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

// According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitch" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = var.vswitch_cidr
  availability_zone = var.availability_zone
}

resource "alicloud_cs_kubernetes" "w3f" {
  count                 = 1
  master_vswitch_ids    = [alicloud_vswitch.vswitch.id]
  worker_vswitch_ids    = [alicloud_vswitch.vswitch.id]
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
