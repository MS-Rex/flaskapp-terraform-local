resource "docker_image" "mysql" {
  name         = "mysql:8.0"
  keep_locally = false
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = var.container_name

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}"
  ]

  networks_advanced {
    name = var.network_name
    aliases = ["mysql-db"]
  }

  ports {
    internal = 3306
    external = var.mysql_port
  }

  restart = "unless-stopped"

  # Health check to ensure MySQL is ready
  healthcheck {
    test = ["CMD", "mysqladmin", "ping", "-h", "localhost"]
    interval = "30s"
    timeout = "10s"
    retries = 5
    start_period = "30s"
  }

  # Volume for persistent data storage
  volumes {
    volume_name    = docker_volume.mysql_data.name
    container_path = "/var/lib/mysql"
  }
}

resource "docker_volume" "mysql_data" {
  name = "${var.container_name}_data"
}