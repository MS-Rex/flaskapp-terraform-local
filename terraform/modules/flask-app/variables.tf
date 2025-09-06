variable "container_name" {
  description = "Name of the Flask application container"
  type        = string
}

variable "image_name" {
  description = "Name of the Flask application Docker image"
  type        = string
}

variable "build_context" {
  description = "Build context path for Docker image"
  type        = string
}

variable "network_name" {
  description = "Name of the Docker network to join"
  type        = string
}

variable "host_port" {
  description = "Host port to forward Flask application"
  type        = number
}

variable "container_port" {
  description = "Container port for Flask application"
  type        = number
}

variable "db_config_path" {
  description = "Path to the database configuration file on host"
  type        = string
}

variable "mysql_container_id" {
  description = "MySQL container ID for dependency"
  type        = string
}