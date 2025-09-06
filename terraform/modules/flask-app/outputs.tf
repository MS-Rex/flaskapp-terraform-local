output "container_name" {
  description = "Name of the Flask application container"
  value       = docker_container.flask_app.name
}

output "container_id" {
  description = "ID of the Flask application container"
  value       = docker_container.flask_app.id
}

output "image_name" {
  description = "Name of the Flask application Docker image"
  value       = docker_image.flask_app.name
}

output "application_url" {
  description = "URL to access the Flask application"
  value       = "http://localhost:${var.host_port}"
}