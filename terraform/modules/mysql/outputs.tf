output "container_name" {
  description = "Name of the MySQL container"
  value       = docker_container.mysql.name
}

output "container_id" {
  description = "ID of the MySQL container"
  value       = docker_container.mysql.id
}

output "mysql_host" {
  description = "MySQL host for application connection"
  value       = "mysql-db"
}

output "mysql_port" {
  description = "MySQL port"
  value       = 3306
}