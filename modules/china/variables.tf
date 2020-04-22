variable "cluster_name" {
  default = "china"
}

variable "region" {
  default = "cn-hangzhou"
}

variable "availability_zones" {
  type    = list(string)
  default = ["cn-hangzhou-e", "cn-hangzhou-f", "cn-hangzhou-g"]
}

variable "vswitch_cidrs" {
  type    = list(string)
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "node_count" {
  default = 2
}

variable "machine_type" {
  default = "ec2.i2.xlarge"
}

variable "k8s_version" {
  default = "1.16.6-aliyun.1"
}

variable "image_type" {
  default = "AliyunLinux2"
}

variable "pod_cidr" {
  default = "10.0.0.0/16"
}

variable "service_cidr" {
  default = "10.0.1.0/16"
}

variable "cluster_addons" {
  description = "Addon components in kubernetes cluster"

  type = list(object({
    name      = string
    config    = string
  }))

  default = [
    {
      "name"     = "flannel",
      "config"   = "",
    },
    {
      "name"     = "flexvolume",
      "config"   = "",
    },
    {
      "name"     = "alicloud-disk-controller",
      "config"   = "",
    },
    {
      "name"     = "logtail-ds",
      "config"   = "{\"IngressDashboardEnabled\":\"true\"}",
    },
    {
      "name"     = "nginx-ingress-controller",
      "config"   = "{\"IngressSlbNetworkType\":\"internet\"}",
    },
  ]
}

variable "kube_cli" {			#K8S config & key files output path in your local machine
  default = {
    cfg = "./kubeconfig"
  }
}
