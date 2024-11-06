provider "aws" {
  region = var.region

  default_tags {
    tags = merge(
      var.L4_tags,
      {
        "blx:environment" = var.environment
      }
    )
  }
}

provider "aws" {
  alias  = "billing"
  region = "us-east-1" # Billing data are available only in this region

  default_tags {
    tags = merge(
      var.L4_tags,
      {
        "blx:environment" = var.environment
      }
    )
  }
}

data "aws_eks_cluster_auth" "eks_auth" {
  name = module.tm_kubernetes_infra.eks_cluster_id
}

provider "kubernetes" {
  host                   = module.tm_kubernetes_infra.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.tm_kubernetes_infra.eks_cluster_certificate_authority)
  token                  = data.aws_eks_cluster_auth.eks_auth.token
}

provider "helm" {
  kubernetes {
    host                   = module.tm_kubernetes_infra.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.tm_kubernetes_infra.eks_cluster_certificate_authority)
    token                  = data.aws_eks_cluster_auth.eks_auth.token
  }
}
