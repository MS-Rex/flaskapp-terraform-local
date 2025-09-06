# Create isolated Docker network
module "network" {
  source = "./modules/network"
  
  network_name = "${var.project_name}-network"
}

# Create MySQL container
module "mysql" {
  source = "./modules/mysql"
  
  container_name        = "${var.project_name}-mysql"
  network_name         = module.network.network_name
  mysql_root_password  = var.mysql_root_password
  mysql_database       = var.mysql_database
  mysql_user          = var.mysql_user
  mysql_password      = var.mysql_password
  mysql_port          = 3306
}

# Create Flask application
module "flask_app" {
  source = "./modules/flask-app"
  
  container_name     = "${var.project_name}-app"
  image_name        = "${var.project_name}-image:latest"
  build_context     = ".."
  network_name      = module.network.network_name
  host_port         = var.flask_host_port
  container_port    = var.flask_container_port
  db_config_path    = abspath("./configs/db_config.py")
  mysql_container_id = module.mysql.container_id
}

