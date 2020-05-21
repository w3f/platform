resource "random_id" "username" {
  byte_length = 14
}

resource "random_id" "password" {
  byte_length = 16
}

resource "google_container_cluster" "playground" {
  name     = var.cluster_name
  location = "${var.region}-${var.zone}"

  min_master_version = var.k8s_version
  node_version = var.k8s_version

  master_auth {
    username = "${random_id.username.hex}"
    password = "${random_id.password.hex}"

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  lifecycle {
    ignore_changes = ["master_auth"]
  }

  network = "${google_compute_network.network.self_link}"
  subnetwork = "${google_compute_subnetwork.subnetwork.self_link}"

  remove_default_node_pool = true
  initial_node_count = 1
}

resource "google_container_node_pool" "playground_nodes" {
  name       = "${var.cluster_name}-playground-pool"
  location   = "${var.region}-${var.zone}"
  cluster    = "${google_container_cluster.playground.name}"
  node_count = var.min_node_count
  version    = var.k8s_version

  management {
    auto_upgrade = false
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    tags = ["playground"]
    image_type = var.image_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}

resource "google_compute_network" "network" {
  name                    = var.cluster_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.cluster_name
  ip_cidr_range = "10.2.0.0/16"
  network       = "${google_compute_network.network.self_link}"
  region        = var.region
}
