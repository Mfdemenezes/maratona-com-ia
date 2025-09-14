# Project Info
output "project_name" {
  description = "Nome do projeto"
  value       = var.project_name
}

output "environment" {
  description = "Ambiente"
  value       = var.environment
}

# EKS Cluster Outputs
output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.main.id
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.main.arn
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

# Node Group Outputs
output "node_groups" {
  description = "EKS node groups"
  value       = aws_eks_node_group.main
}

output "node_group_desired_size" {
  description = "Número desejado de nodes"
  value       = var.node_group_desired_size
}

output "node_group_instance_types" {
  description = "Tipos de instância dos nodes"
  value       = var.node_group_instance_types
}

output "node_group_capacity_type" {
  description = "Tipo de capacidade dos nodes"
  value       = var.node_group_capacity_type
}

output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

# Database Outputs
output "db_instance_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "db_instance_name" {
  description = "RDS instance name"
  value       = aws_db_instance.main.db_name
}

output "db_instance_class" {
  description = "Classe da instância RDS"
  value       = var.db_instance_class
}

output "db_allocated_storage" {
  description = "Armazenamento alocado do RDS"
  value       = var.db_allocated_storage
}

# Application Outputs
output "app_image" {
  description = "Imagem Docker da aplicação"
  value       = var.app_image
}

output "app_replicas" {
  description = "Número de replicas da aplicação"
  value       = var.app_replicas
}

output "app_cpu_request" {
  description = "CPU request da aplicação"
  value       = var.app_cpu_request
}

output "app_memory_request" {
  description = "Memory request da aplicação"
  value       = var.app_memory_request
}

output "app_cpu_limit" {
  description = "CPU limit da aplicação"
  value       = var.app_cpu_limit
}

output "app_memory_limit" {
  description = "Memory limit da aplicação"
  value       = var.app_memory_limit
}

output "db_username" {
  description = "Username do banco de dados"
  value       = var.db_username
}

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block da VPC"
  value       = var.vpc_cidr
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "enable_public_nodes" {
  description = "Se os nodes estão em subnets públicas"
  value       = var.enable_public_nodes
}

# URL da aplicação (será preenchido após deploy do LoadBalancer)
output "application_url" {
  description = "URL da aplicação (LoadBalancer)"
  value       = "Será exibido após o deploy do Kubernetes"
}