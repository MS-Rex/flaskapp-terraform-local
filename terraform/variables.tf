variable "project_name" {
  description = "Name of the project used for resource naming"
  type        = string
  default     = "flaskapp"
}

variable "mysql_root_password" {
  description = "Root password for MySQL database"
  type        = string
  sensitive   = true
  default     = "rootpassword123"
}

variable "mysql_database" {
  description = "Name of the MySQL database"
  type        = string
  default     = "mylistdb"
}

variable "mysql_user" {
  description = "MySQL user for application"
  type        = string
  default     = "admin"
}

variable "mysql_password" {
  description = "MySQL password for application user"
  type        = string
  sensitive   = true
  default     = "password"
}

variable "flask_host_port" {
  description = "Host port to forward Flask application"
  type        = number
  default     = 5000
}

variable "flask_container_port" {
  description = "Container port for Flask application"
  type        = number
  default     = 5000
}