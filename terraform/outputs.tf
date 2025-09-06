output "network_name" {
  description = "Name of the created Docker network"
  value       = module.network.network_name
}

output "mysql_container_name" {
  description = "Name of the MySQL container"
  value       = module.mysql.container_name
}

output "flask_container_name" {
  description = "Name of the Flask application container"
  value       = module.flask_app.container_name
}

output "flask_image_name" {
  description = "Name of the Flask application Docker image"
  value       = module.flask_app.image_name
}

output "application_url" {
  description = "URL to access the Flask application"
  value       = module.flask_app.application_url
}

output "deployment_summary" {
  description = "Summary of the deployed infrastructure"
  value = {
    network      = module.network.network_name
    mysql_host   = module.mysql.mysql_host
    mysql_port   = module.mysql.mysql_port
    app_url      = module.flask_app.application_url
    containers   = [
      module.mysql.container_name,
      module.flask_app.container_name
    ]
  }
}