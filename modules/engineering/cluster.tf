resource "random_id" "username" {
  byte_length = 14
}

resource "random_id" "password" {
  byte_length = 16
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location

  min_master_version = var.k8s_version

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

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "${var.cluster_name}-pool"
  location   = var.location
  cluster    = "${google_container_cluster.primary.name}"
  node_count = var.node_count
  version    = var.k8s_version

  management {
    auto_upgrade = false
  }

  node_config {
    preemptible  = false
    machine_type = var.machine_type
    image_type   = var.image_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "google_compute_firewall" "bitcoin" {
  name     = "bitcoin-firewall"
  network = google_compute_network.network.name
  allow {
    protocol = "tcp"
    ports    = ["8332-8333"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "network" {
  name                    = var.cluster_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.cluster_name
  ip_cidr_range = "10.2.0.0/16"
  network       = "${google_compute_network.network.self_link}"
  region        = var.location
}
