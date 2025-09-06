variable "container_name" {
  description = "Name of the MySQL container"
  type        = string
}

variable "network_name" {
  description = "Name of the Docker network to join"
  type        = string
}

variable "mysql_root_password" {
  description = "Root password for MySQL"
  type        = string
  sensitive   = true
}

variable "mysql_database" {
  description = "Name of the database to create"
  type        = string
}

variable "mysql_user" {
  description = "MySQL user to create"
  type        = string
}

variable "mysql_password" {
  description = "Password for the MySQL user"
  type        = string
  sensitive   = true
}

variable "mysql_port" {
  description = "External port for MySQL container"
  type        = number
  default     = 3306
}