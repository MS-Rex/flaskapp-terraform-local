# Flask List Manager

A simple web application built with Flask that allows users to manage a list of items. Users can add new items, view all items, and delete existing items. The application uses MySQL as the database and includes Docker containerization and Terraform infrastructure automation.

## Features

- ✅ Add new items to your list
- 📋 View all items in your list
- 🗑️ Delete items from your list
- 🐳 Docker containerization support
- 🏗️ Terraform infrastructure as code
- 🔒 MySQL database integration

## Prerequisites

### For Local Development

- Python 3.10+
- MySQL Server
- pip (Python package manager)

### For Docker Deployment

- Docker
- Docker Compose (optional)

### For Terraform Deployment

- Docker
- Terraform
- Docker provider for Terraform

## Installation & Setup

### Method 1: Local Development

1. **Clone the repository**

   ```bash
   git clone <your-repo-url>
   cd FlaskApp
   ```

2. **Create and activate virtual environment**

   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**

   ```bash
   pip install -r requirements.txt
   ```

4. **Setup MySQL Database**

   - Create a MySQL database named `mylistdb`
   - Create a user with username `admin` and password `password`
   - Grant all privileges on `mylistdb` to the user

   ```sql
   CREATE DATABASE mylistdb;
   CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';
   GRANT ALL PRIVILEGES ON mylistdb.* TO 'admin'@'localhost';
   FLUSH PRIVILEGES;
   ```

5. **Update database configuration (if needed)**
   Edit `config/db_config.py` to match your MySQL setup:

   ```python
   DB_CONFIG = {
       'host': 'localhost',
       'user': 'admin',
       'password': 'password',
       'database': 'mylistdb'
   }
   ```

6. **Run the application**
   ```bash
   python app.py
   ```

The application will be available at `http://localhost:5000`

### Method 2: Docker

1. **Clone the repository**

   ```bash
   git clone <your-repo-url>
   cd FlaskApp
   ```

2. **Build and run with Docker**

   ```bash
   # Build the Docker image
   docker build -t flask-list-app .

   # Run MySQL container
   docker run -d \
     --name mysql-db \
     -e MYSQL_ROOT_PASSWORD=rootpassword123 \
     -e MYSQL_DATABASE=mylistdb \
     -e MYSQL_USER=admin \
     -e MYSQL_PASSWORD=password \
     -p 3306:3306 \
     mysql:8.0

   # Run Flask app container (linked to MySQL)
   docker run -d \
     --name flask-app \
     --link mysql-db:mysql \
     -p 5000:5000 \
     flask-list-app
   ```

### Method 3: Terraform (Recommended)

1. **Clone the repository**

   ```bash
   git clone <your-repo-url>
   cd FlaskApp/terraform
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Copy and configure variables**

   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars if you want to change default values
   ```

4. **Deploy the infrastructure**
   ```bash
   terraform plan
   terraform apply
   ```

This will automatically:

- Create a Docker network
- Deploy MySQL container with proper configuration
- Build and deploy the Flask application container
- Set up all necessary connections

5. **Access the application**
   The application will be available at `http://localhost:5000`

6. **Clean up (when done)**
   ```bash
   terraform destroy
   ```

## Usage

### Web Interface

1. **Home Page**: Navigate to `http://localhost:5000`
2. **Add Items**: Go to `/add` or click "Add More" to add new items
3. **View Items**: Go to `/show` or click "View Items" to see your list
4. **Delete Items**: Click "Delete" next to any item in the list view

### API Endpoints

- `GET /` - Home page with welcome message
- `GET /add` - Display form to add new items
- `POST /add` - Submit new item to the list
- `GET /show` - Display all items in the list
- `GET /delete/<id>` - Delete specific item by ID

## Project Structure

```
FlaskApp/
├── app.py                 # Main Flask application
├── requirements.txt       # Python dependencies
├── Dockerfile            # Docker image definition
├── README.md            # This file
├── config/
│   └── db_config.py     # Database configuration
├── templates/           # HTML templates
│   ├── add.html        # Add item form
│   └── show.html       # Show items list
├── terraform/          # Infrastructure as Code
│   ├── main.tf         # Main Terraform configuration
│   ├── variables.tf    # Terraform variables
│   ├── terraform.tfvars.example # Example variables
│   └── modules/        # Terraform modules
│       ├── flask-app/  # Flask application module
│       ├── mysql/      # MySQL database module
│       └── network/    # Docker network module
└── venv/              # Python virtual environment (local)
```

## Database Schema

The application uses a simple MySQL table:

```sql
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL
);
```

## Configuration

### Database Configuration

Update `config/db_config.py` to modify database connection settings:

```python
DB_CONFIG = {
    'host': 'localhost',     # Database host
    'user': 'admin',         # Database user
    'password': 'password',  # Database password
    'database': 'mylistdb'   # Database name
}
```

### Terraform Variables

Modify `terraform/terraform.tfvars` to customize deployment:

```hcl
project_name = "flaskapp"
mysql_root_password = "your-secure-password"
mysql_database = "mylistdb"
mysql_user = "admin"
mysql_password = "your-secure-password"
flask_host_port = 5000
flask_container_port = 5000
```

## Development

### Adding New Features

1. Create a new branch for your feature
2. Make your changes to the Flask application
3. Update templates as needed
4. Test locally using Method 1 (Local Development)
5. Test with Docker using Method 2
6. Submit a pull request

### Database Migrations

The application automatically creates the required table on startup. For schema changes:

1. Update the `init_db()` function in `app.py`
2. Consider adding migration scripts for existing deployments

## Troubleshooting

### Common Issues

**"Access denied for user" error:**

- Check MySQL user credentials in `config/db_config.py`
- Ensure MySQL user has proper privileges

**"Can't connect to MySQL server" error:**

- Verify MySQL is running
- Check host/port configuration
- For Docker: ensure containers are on the same network

**Port already in use:**

- Change port in Terraform variables or Docker run commands
- Check if other applications are using port 5000

**Terraform deployment fails:**

- Ensure Docker is running
- Check if ports 5000 and 3306 are available
- Run `terraform destroy` and try again

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Security Note

⚠️ **Important**: This application is for educational/demonstration purposes. For production use:

- Change default passwords and use environment variables
- Implement proper authentication and authorization
- Add input validation and sanitization
- Use HTTPS in production
- Follow security best practices for database connections
- Implement proper error handling and logging

## Contact

For questions or support, please open an issue in the repository.
