# Maratona com IA - Projeto EKS + Terraform

Projeto de CI/CD completo com AWS EKS, Terraform e GitHub Actions.

## 🏗️ Arquitetura

- **VPC** com subnets públicas e privadas
- **EKS Cluster** com node group em subnets públicas
- **RDS PostgreSQL** para banco de dados
- **LoadBalancer** para acesso à aplicação
- **Estado do Terraform** armazenado no S3

## 🚀 Deploy

### Deploy Automático (GitHub Actions)

1. **Push para main**: Deploy automático da aplicação
2. **Manual Deploy**: Use `workflow_dispatch` com action: `deploy`
3. **Manual Destroy**: Use `workflow_dispatch` com action: `destroy`

### Deploy Local

```bash
# Ir para o diretório terraform
cd terraform

# Inicializar (primeira vez)
terraform init

# Planejar mudanças
terraform plan

# Aplicar infraestrutura
terraform apply

# Configurar kubectl
aws eks update-kubeconfig --name encontros-tech-cluster --region us-east-1

# Criar secret do banco (substitua ENDPOINT pelo output do terraform)
kubectl create secret generic database-secret \
  --from-literal=database-url="postgresql://mfdemenezes:Mfm38111@ENDPOINT/encontrostechdb?sslmode=require"

# Deploy da aplicação
kubectl apply -f ../k8s/
```

## 🗑️ Destruir Infraestrutura

```bash
# Remover aplicação Kubernetes
kubectl delete -f ../k8s/

# Destruir infraestrutura
terraform destroy
```

## 🔧 Configuração

### Secrets GitHub Actions

Configure os seguintes secrets no GitHub:

- `DOCKERHUB_USERNAME`: Usuário do Docker Hub
- `DOCKERHUB_TOKEN`: Token do Docker Hub
- `AWS_ACCESS_KEY_ID`: Access Key da AWS
- `AWS_SECRET_ACCESS_KEY`: Secret Key da AWS

### S3 Backend

O estado do Terraform é armazenado em:
- **Bucket**: `terraform-state-marcelo-menezes`
- **Key**: `encontros-tech/terraform.tfstate`
- **Região**: `us-east-1`

## 📁 Estrutura do Projeto

```
├── .github/workflows/main.yml    # Pipeline CI/CD
├── terraform/                    # Infraestrutura como código
│   ├── main.tf                  # Configuração principal + backend S3
│   ├── eks.tf                   # Cluster EKS e node group
│   ├── rds.tf                   # Banco RDS PostgreSQL
│   ├── variables.tf             # Variáveis
│   ├── outputs.tf              # Outputs
│   └── terraform.tfvars         # Valores das variáveis
├── k8s/                         # Manifests Kubernetes
│   ├── deployment.yaml          # Deployment + Service
│   └── service-account.yaml     # Service Account + RBAC
└── src/                         # Código da aplicação Python
```

## 🔐 Segurança

- ✅ Estado do Terraform no S3 (não local)
- ✅ Secrets não commitados (.gitignore configurado)
- ✅ Credenciais via GitHub Secrets
- ✅ RDS em subnet privada com security groups
- ✅ RBAC configurado no Kubernetes

## 🌐 Acesso à Aplicação

Após o deploy, a aplicação ficará acessível via LoadBalancer.
O URL será exibido no final do job `Deploy-Infrastructure`.

## ⚙️ Configuração Flexível com Variáveis

### 🎯 Variáveis Principais

O projeto foi otimizado para ser altamente configurável através de variáveis no `terraform.tfvars`:

#### **EKS Configuration**
```hcl
# Quantidade e tipo de nodes
node_group_instance_types = ["t3.medium"]      # Tipos de instância
node_group_capacity_type  = "ON_DEMAND"        # ON_DEMAND ou SPOT
node_group_min_size      = 1                   # Mínimo de nodes
node_group_max_size      = 4                   # Máximo de nodes
node_group_desired_size  = 2                   # Quantidade desejada
node_group_disk_size     = 20                  # Tamanho do disco (GB)
enable_public_nodes      = true                # Nodes públicos ou privados
```

#### **Database Configuration**
```hcl
db_instance_class           = "db.t3.micro"    # Classe da instância RDS
db_allocated_storage        = 20               # Armazenamento inicial (GB)
db_max_allocated_storage    = 100              # Armazenamento máximo (GB)
db_backup_retention_days    = 7                # Dias de retenção backup
```

#### **Application Configuration**
```hcl
app_image           = "mfdemenezes/maratona-com-ia:latest"
app_replicas        = 2                        # Quantidade de pods
app_cpu_request     = "100m"                   # CPU request
app_memory_request  = "128Mi"                  # Memory request
app_cpu_limit       = "200m"                   # CPU limit
app_memory_limit    = "256Mi"                  # Memory limit
```

#### **Network Configuration**
```hcl
vpc_cidr           = "10.0.0.0/16"             # CIDR da VPC
enable_nat_gateway = true                      # NAT Gateway ($$)
```

### 📋 Cenários de Uso

#### 💰 **Configuração Econômica**
```hcl
# Para desenvolvimento/testes - menor custo
node_group_instance_types = ["t3.small"]
node_group_capacity_type  = "SPOT"             # 60-90% mais barato
node_group_desired_size  = 1
enable_nat_gateway       = false              # Economiza ~$45/mês
db_instance_class        = "db.t3.micro"
app_replicas            = 1
```

#### 🚀 **Configuração de Produção**
```hcl
# Para produção - alta disponibilidade
node_group_instance_types = ["t3.large"]
node_group_min_size      = 2
node_group_max_size      = 10
node_group_desired_size  = 4
enable_public_nodes      = false              # Nodes privados
db_instance_class        = "db.r5.large"
db_backup_retention_days = 30
app_replicas            = 5
```

#### 🧪 **Configuração para Load Test**
```hcl
# Para testes de carga
node_group_instance_types = ["c5.large"]      # CPU-optimized
node_group_max_size      = 20
db_instance_class        = "db.r5.xlarge"     # Memory-optimized
app_replicas            = 10
```

### 📖 Exemplos Completos

Veja `terraform/terraform.tfvars.examples` para configurações completas dos cenários:
- Configuração Básica (atual)
- Configuração Econômica
- Configuração de Produção
- Configuração de Desenvolvimento
- Configuração Multi-região
- Configuração para Load Tests

### 🔄 Como Usar

1. Copie `terraform.tfvars.examples` para `terraform.tfvars`
2. Descomente e modifique o cenário desejado
3. Execute `terraform plan` para revisar mudanças
4. Execute `terraform apply` para aplicar

### 🎛️ Tipos de Instância Disponíveis

**EKS Nodes:**
- **Uso geral**: t3.micro → t3.2xlarge, m5.large → m5.24xlarge
- **CPU otimizado**: c5.large → c5.24xlarge
- **Memory otimizado**: r5.large → r5.24xlarge

**RDS Database:**
- **Básico**: db.t3.micro → db.t3.2xlarge
- **Memory otimizado**: db.r5.large → db.r5.24xlarge