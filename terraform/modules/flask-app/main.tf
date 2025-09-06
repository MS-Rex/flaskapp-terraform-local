# Build the Flask application Docker image
resource "docker_image" "flask_app" {
  name = var.image_name
  build {
    context    = var.build_context
    dockerfile = "Dockerfile"
    tag        = [var.image_name]
  }
  keep_locally = false
}

# Create Flask application container
resource "docker_container" "flask_app" {
  image = docker_image.flask_app.image_id
  name  = var.container_name

  networks_advanced {
    name = var.network_name
  }

  ports {
    internal = var.container_port
    external = var.host_port
  }

  # Mount the database configuration file
  volumes {
    host_path      = var.db_config_path
    container_path = "/app/config/db_config.py"
    read_only      = true
  }

  env = [
    "FLASK_ENV=production"
  ]

  restart = "unless-stopped"

  # Health check for the Flask application
  healthcheck {
    test         = ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost:${var.container_port}/" ]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "40s"
  }

  # MySQL container starts first
  depends_on = [var.mysql_container_id]
}

