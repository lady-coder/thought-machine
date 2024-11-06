locals {
  modules = {
    # L1 Modules
    autoscaling-group = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    cloudwatch-log-group = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    codeartifact = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    dynamodb = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    eks-irsa-role = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    github-oidc = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    kafka-iam = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    kms = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    s3-private = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    secrets-manager = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },
    ssm-parameter = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L1"
    },

    # L2 Modules
    alb-prerequisites = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    athena-database = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    athena-table = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    athena-view = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    athena-workgroup = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    aurora = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    billing-alerts = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    confluent-connector = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    confluent-operator = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    default-vpc = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    ebs-backup = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    ec2-worker-pool = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    ecr = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    eks-auth = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    eks-cluster = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    eks-node-group = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    emr-on-eks = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    emr-on-eks-policy = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    glue-registry = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    helm-applications-infrastructure = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    helm-argocd = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    helm-external-secrets = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    jumphost = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    kms-apps = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    kms-data = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    kms-networking = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    kms-shared-services = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    kms-tm = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    msk = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    mwaa = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    spacelift-worker-pool = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    tm-prime-vpc = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },
    waf = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L2"
    },

    # L3 Modules
    skeleton-applications = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-base-deployments = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-core = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-data = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-kubernetes = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-networking = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-observability = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-tm-applications = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-tm-networking = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    },
    skeleton-shared-services = {
      branch                = "main",
      administrative        = false,
      protect_from_deletion = true,
      module_level          = "L3"
    }
  }
}
