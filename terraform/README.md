# Infraestrutura AWS - Terraform

Este projeto provisiona a infraestrutura completa na AWS para a aplicação `encontros-tech`.

## Recursos Provisionados

- **VPC** com subnets públicas e privadas
- **EKS Cluster** com node groups
- **RDS PostgreSQL** para banco de dados
- **Security Groups** e IAM Roles
- **Load Balancer** via Kubernetes Service

## Pré-requisitos

1. AWS CLI instalado e configurado
2. Terraform instalado (>= 1.0)
3. kubectl instalado

## Como Usar

### 1. Configurar Variáveis

```bash
cp terraform.tfvars.example terraform.tfvars
# Edite o arquivo com seus valores
```

### 2. Inicializar Terraform

```bash
terraform init
```

### 3. Planejar e Aplicar

```bash
terraform plan
terraform apply
```

### 4. Configurar kubectl

```bash
aws eks update-kubeconfig --region us-west-2 --name encontros-tech-cluster
```

### 5. Deploy da Aplicação

```bash
# Atualizar o endpoint do banco no secret
kubectl apply -f ../k8s/database-secret.yaml
kubectl apply -f ../k8s/service-account.yaml
kubectl apply -f ../k8s/deployment.yaml
```

## Próximos Passos

1. Configure os secrets do GitHub Actions:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `DOCKERHUB_USERNAME`
   - `DOCKERHUB_TOKEN`

2. Atualize o endpoint do RDS no arquivo `k8s/database-secret.yaml`

3. Configure um domínio personalizado para o LoadBalancer (opcional)

## Limpeza

```bash
terraform destroy
```