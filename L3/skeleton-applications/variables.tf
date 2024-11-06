variable "environment" {
  description = "Environment"
  type        = string
}

variable "component" {
  type        = string
  description = "Component"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the skeleton will be deployed"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of the VPC where the skeleton will be deployed"
}

variable "eks_workers_subnet_cidrs" {
  type        = list(string)
  description = "List of cluster private subnets CIDRs which will be added to the ALB security groups egress rules"
}

variable "public_domain_name" {
  type        = string
  description = "Public domain name for which the ACM certificates will be generated"
}

variable "s3_cmk_arn" {
  type        = string
  description = "CMK for S3"
}

variable "secretsmanager_cmk_arn" {
  type        = string
  description = "CMK for Secrets Manager"
}

variable "iam_openid_connect_provider_url" {
  type        = string
  description = "URL of OIDC provider for target cluster"
}

variable "iam_openid_connect_provider_arn" {
  type        = string
  description = "ARN of OIDC provider for target cluster"
}

variable "eks_cluster_arn" {
  type        = string
  description = "EKS cluster ARN"
}

variable "apollo_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access Apollo"
}

variable "microservices_ingress_allowed_ip_ranges" {
  type        = list(string)
  description = "CIDRs allowed to access microservices"
}

variable "glue_registry_names" {
  type        = set(string)
  description = "Names of Glue registries"
}

variable "microservices_glue_registry" {
  type        = string
  description = "The Name of the main Glue registry"
}

variable "apps_cluster_worker_node_role_name" {
  type        = string
  description = "ARN of Apps cluster worker node IAM role to be extended with additional privileges"
}

variable "apps_aurora_cluster_resource_id" {
  type        = string
  description = "Apps Aurora cluster resource ID"
}

variable "enable_kafka_ui" {
  type        = bool
  description = "Enable Kafka UI"
}

variable "datatech_airflowdags_bucket_arn" {
  type        = string
  description = "ARN of bucket with data Airflow jobs definition"
}

variable "s3_bronze_bucket_names" {
  type        = set(string)
  description = "Names of bronze buckets"
}