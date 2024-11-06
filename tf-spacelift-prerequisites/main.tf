module "shared_service_spacelift_prequisites" {

  source      = "./modules/common-spacelift-prerequisites"
  region      = var.region
  environment = "shared-service"

  ecr_iam_principal = [
    var.shared_service_admin_role,
    var.shared_service_github_role
  ]

  spacelift_repositories = [
    "spacelift/terraform-runner"
  ]
  platform_repositories = [
    # Helm Charts
    "${var.platform_helm_chart_ecr_prefix}/argo-cd",          # https://argoproj.github.io/argo-helm
    "${var.platform_helm_chart_ecr_prefix}/external-secrets", # https://charts.external-secrets.io
    "aws-ebs-csi-driver",
    "aws-load-balancer-controller",
    "cert-manager",
    "cloudwatch-container-insights",
    "cluster-autoscaler",
    "external-dns",
    "metrics-server",
    "prometheus-blackbox-exporter",
    "reloader",
    "system-customizations",

    # Container Registries
    "${var.platform_image_ecr_prefix}/actions-runner-controller",    # summerwind/actions-runner-controller
    "${var.platform_image_ecr_prefix}/argocd",                       # quay.io/argoproj/argocd
    "${var.platform_image_ecr_prefix}/aws-ebs-csi-driver",           # public.ecr.aws/ebs-csi-driver/aws-ebs-csi-driver
    "${var.platform_image_ecr_prefix}/aws-load-balancer-controller", # public.ecr.aws/eks/aws-load-balancer-controller
    "${var.platform_image_ecr_prefix}/aws-xray-daemon",              # public.ecr.aws/xray/aws-xray-daemon
    "${var.platform_image_ecr_prefix}/blackbox-exporter",            # public.ecr.aws/bitnami/blackbox-exporter
    "${var.platform_image_ecr_prefix}/cert-manager-acmesolver",      # quay.io/jetstack/cert-manager-acmesolver
    "${var.platform_image_ecr_prefix}/cert-manager-cainjector",      # quay.io/jetstack/cert-manager-cainjector
    "${var.platform_image_ecr_prefix}/cert-manager-controller",      # quay.io/jetstack/cert-manager-controller
    "${var.platform_image_ecr_prefix}/cert-manager-ctl",             # quay.io/jetstack/cert-manager-ctl
    "${var.platform_image_ecr_prefix}/cert-manager-webhook",         # quay.io/jetstack/cert-manager-webhook
    "${var.platform_image_ecr_prefix}/cloudwatch-agent",             # public.ecr.aws/cloudwatch-agent/cloudwatch-agent
    "${var.platform_image_ecr_prefix}/cluster-autoscaler",           # k8s.gcr.io/autoscaling/cluster-autoscaler
    "${var.platform_image_ecr_prefix}/docker-in-docker",             # hub.docker.com/_/docker
    "${var.platform_image_ecr_prefix}/external-dns",                 # k8s.gcr.io/external-dns/external-dns
    "${var.platform_image_ecr_prefix}/external-secrets",             # ghcr.io/external-secrets/external-secrets
    "${var.platform_image_ecr_prefix}/fluent-bit",                   # public.ecr.aws/aws-observability/aws-for-fluent-bit
    "${var.platform_image_ecr_prefix}/github-actions-runner",        # summerwind/actions-runner
    "${var.platform_image_ecr_prefix}/kube-rbac-proxy",              # quay.io/brancz/kube-rbac-proxy
    "${var.platform_image_ecr_prefix}/kubectl",                      # public.ecr.aws/bitnami/kubectl
    "${var.platform_image_ecr_prefix}/metrics-server",               # k8s.gcr.io/metrics-server/metrics-server
    "${var.platform_image_ecr_prefix}/postgresql",                   # bitnami/postgresql
    "${var.platform_image_ecr_prefix}/redis",                        # public.ecr.aws/docker/library/redis
    "${var.platform_image_ecr_prefix}/reloader",                     # stakater/reloader
  ]
}

module "shared-service-state-buckets" {
  source      = "./modules/shared-service-state-buckets"
  region      = var.region
  environment = "shared-service"
  prefix      = var.prefix

  L4_tags = var.L4_tags
}

module "sandbox_skeleton_state_buckets" {
  source      = "./modules/skeleton-state-buckets"
  region      = var.region
  environment = "sandbox"
  prefix      = var.prefix

  L4_tags = var.L4_tags
}

module "sandbox_tm_skeleton_state_buckets" {
  source      = "./modules/sandbox-tm-state-buckets"
  region      = var.region
  environment = "sandbox"
  prefix      = var.prefix

  L4_tags = var.L4_tags
}

module "platform_secret_prerequisites" {
  source      = "./modules/platform-secrets"
  region      = var.region
  environment = "sandbox"
  component   = "apps"

  create_appmesh_certificate_secrets  = true
  create_apollo_api_key_secret        = true
  create_microservices_api_key_secret = true

  L4_tags = var.L4_tags
}

module "tm_platform_secret_prerequisites" {
  source      = "./modules/platform-secrets"
  region      = var.region
  environment = "sandbox"
  component   = "tm"

  L4_tags = var.L4_tags
}

module "shared_services_secret_prerequisites" {
  source      = "./modules/platform-secrets"
  region      = var.region
  environment = "shared-services"
  component   = "ci"

  L4_tags = var.L4_tags
}

module "data_secret_prerequisites" {
  source      = "./modules/platform-secrets"
  region      = var.region
  environment = "sandbox"
  component   = "data"

  L4_tags = var.L4_tags
}
