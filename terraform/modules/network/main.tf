resource "docker_network" "app_network" {
  name   = var.network_name
  driver = "bridge"

  ipam_config {
    subnet = "172.20.0.0/16"
  }
}