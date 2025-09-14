variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "encontros-tech"
}

variable "aws_region" {
  description = "Região AWS"
  type        = string
  default     = "us-east-1"
}

variable "cluster_version" {
  description = "Versão do cluster EKS"
  type        = string
  default     = "1.28"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "prod"
}

# EKS Configuration
variable "node_group_instance_types" {
  description = "Tipos de instância para o node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_group_capacity_type" {
  description = "Tipo de capacidade do node group (ON_DEMAND ou SPOT)"
  type        = string
  default     = "ON_DEMAND"
  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.node_group_capacity_type)
    error_message = "Capacity type deve ser ON_DEMAND ou SPOT."
  }
}

variable "node_group_min_size" {
  description = "Número mínimo de nodes"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Número máximo de nodes"
  type        = number
  default     = 4
}

variable "node_group_desired_size" {
  description = "Número desejado de nodes"
  type        = number
  default     = 2
}

variable "node_group_disk_size" {
  description = "Tamanho do disco dos nodes em GB"
  type        = number
  default     = 20
}

variable "enable_public_nodes" {
  description = "Se true, nodes ficam em subnets públicas com IP público"
  type        = bool
  default     = true
}

# Database Configuration
variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "encontrostechdb"
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
  default     = "mfdemenezes"
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "Classe da instância RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Armazenamento inicial do RDS em GB"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Armazenamento máximo do RDS em GB"
  type        = number
  default     = 100
}

variable "db_backup_retention_days" {
  description = "Dias de retenção do backup"
  type        = number
  default     = 7
}

variable "db_instance_count" {
  description = "Quantidade de instâncias de banco de dados"
  type        = number
  default     = 1
  validation {
    condition     = var.db_instance_count >= 1 && var.db_instance_count <= 10
    error_message = "A quantidade de instâncias deve estar entre 1 e 10."
  }
}

# Application Configuration
variable "app_image" {
  description = "Imagem Docker da aplicação"
  type        = string
  default     = "mfdemenezes/maratona-com-ia:latest"
}

variable "app_replicas" {
  description = "Número de replicas da aplicação"
  type        = number
  default     = 2
}

variable "app_cpu_request" {
  description = "CPU request para cada pod"
  type        = string
  default     = "100m"
}

variable "app_memory_request" {
  description = "Memory request para cada pod"
  type        = string
  default     = "128Mi"
}

variable "app_cpu_limit" {
  description = "CPU limit para cada pod"
  type        = string
  default     = "200m"
}

variable "app_memory_limit" {
  description = "Memory limit para cada pod"
  type        = string
  default     = "256Mi"
}

# Networking
variable "vpc_cidr" {
  description = "CIDR block para a VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Habilita NAT Gateway para subnets privadas"
  type        = bool
  default     = true
}