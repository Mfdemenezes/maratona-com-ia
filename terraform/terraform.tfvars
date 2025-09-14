# Project Configuration
project_name = "encontros-tech"
aws_region   = "us-east-1"
environment  = "prod"

# EKS Configuration
cluster_version           = "1.28"
node_group_instance_types = ["t3.medium"]
node_group_capacity_type  = "ON_DEMAND" # ou "SPOT" para economizar
node_group_min_size       = 1
node_group_max_size       = 4
node_group_desired_size   = 2
node_group_disk_size      = 20
enable_public_nodes       = true # false para nodes privados

# Database Configuration
db_name                  = "encontrostechdb"
db_username              = "mfdemenezes"
db_password              = "Mfm38111"
db_instance_class        = "db.t3.micro" # ou db.t3.small, db.r5.large, etc.
db_allocated_storage     = 20
db_max_allocated_storage = 100
db_backup_retention_days = 7

# Application Configuration
app_image          = "mfdemenezes/maratona-com-ia:latest"
app_replicas       = 2
app_cpu_request    = "100m"
app_memory_request = "128Mi"
app_cpu_limit      = "200m"
app_memory_limit   = "256Mi"

# Network Configuration
vpc_cidr           = "10.0.0.0/16"
enable_nat_gateway = true # false para desabilitar NAT (economiza $)