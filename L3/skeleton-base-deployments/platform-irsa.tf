
/*
Please add all the new IRSA modules to the external-secrets dependsOn block
*/

# IRSA policy for external-secrets platform application deployed via terraform
data "aws_iam_policy_document" "external_secret" {
  statement {
    sid = "PlatformSecretsAccess"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    effect = "Allow"
    resources = compact(flatten([[
      local.platform_secrets_range_arn,
      local.microservices_secrets_range_arn
      ],
      var.additional_secrets_range_arn
    ]))
  }

  statement {
    sid = "PlatformECRAccess"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}


module "external_secrets_iam_service_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.1.1"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  inline_policy                   = data.aws_iam_policy_document.external_secret.json

  scope            = join("-", compact([var.prefix, var.environment, var.component]))
  namespace        = "external-secrets"
  application_name = "external-secrets"
}

/*-------------------------------------------------------------------------*/

# IRSA policy for cluster-autoscaler platform application deployed via env dedicated platform gitops repository
data "aws_iam_policy_document" "cluster_autoscaler" {
  #checkov:skip=CKV_AWS_111:Will only affect properly tagged autoscaling groups
  statement {
    sid = "AutoScalingGroups"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    sid = "EC2Describe"
    actions = [
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplateVersions",
      "ec2:DescribeImages",
      "ec2:GetInstanceTypesFromInstanceRequirements",
      "eks:DescribeNodegroup"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

/*-------------------------------------------------------------------------*/

# IRSA policy for cert-manager platform application deployed via env dedicated platform gitops repository
data "aws_iam_policy_document" "cert_manager" {
  statement {
    sid    = "GetChange"
    effect = "Allow"
    actions = [
      "route53:GetChange",
    ]
    resources = [
      "arn:aws:route53:::change/*",
    ]
  }

  statement {
    sid    = "ChangeRecordSets"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }

  statement {
    sid    = "ListHostedZones"
    effect = "Allow"
    actions = [
      "route53:ListHostedZonesByName"
    ]
    resources = ["*"]
  }
}

/*-------------------------------------------------------------------------*/

# IRSA policy for Fluent Bit platform application deployed via env dedicated platform gitops repository
data "aws_iam_policy_document" "fluent_bit" {
  #checkov:skip=CKV_AWS_111: "Ensure IAM policies does not allow write access without constraints"
  statement {
    sid    = "GetChange"
    effect = "Allow"
    actions = [
      "cloudwatch:PutMetricData",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:DescribeLogGroups",
      "logs:CreateLogStream"
    ]
    resources = [
      "*",
    ]
  }
}

/*-------------------------------------------------------------------------*/

module "platform_base_irsa_roles" {
  for_each = tomap({
    argocd = {
      namespace : "argo-cd"
      application_name : "argocd-repo-server"
      inline_policy : ""
      policy_arns : [
        "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      ]
    }
    cluster-autoscaler = {
      namespace : "cluster-autoscaler"
      application_name : "cluster-autoscaler"
      inline_policy : data.aws_iam_policy_document.cluster_autoscaler.json
      policy_arns : []
    }
    cert_manager = {
      namespace : "cert-manager"
      application_name : "cert-manager"
      inline_policy : data.aws_iam_policy_document.cert_manager.json
      policy_arns : []
    }
    fluent_bit = {
      namespace : "amazon-cloudwatch"
      application_name : "fluent-bit"
      inline_policy : data.aws_iam_policy_document.fluent_bit.json
      policy_arns : []
    }
    cloudwatch_agent = {
      namespace : "amazon-cloudwatch"
      application_name : "cloudwatch-agent"
      inline_policy : ""
      policy_arns : [
        "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
      ]
    }
    xray_daemon = {
      namespace : "amazon-cloudwatch"
      application_name : "xray-daemon"
      inline_policy : ""
      policy_arns : [
        "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
      ]
    }
    prometheus_blackbox_exporter = {
      namespace : "prometheus-blackbox-exporter"
      application_name : "prometheus-blackbox-exporter"
      inline_policy : ""
      policy_arns : [
        "arn:aws:iam::aws:policy/AWSAppMeshEnvoyAccess"
      ]
    }
    }
  )

  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.1.1"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  inline_policy                   = each.value.inline_policy
  policy_arns                     = each.value.policy_arns

  scope            = join("-", compact([var.prefix, var.environment, var.component]))
  namespace        = each.value.namespace
  application_name = each.value.application_name
}

module "platform_env_dedicated_irsa_roles" {
  for_each = var.env_dedicated_irsa_roles

  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.1.1"

  iam_openid_connect_provider_url        = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn        = var.iam_openid_connect_provider_arn
  custom_iam_openid_connect_provider_url = each.value.custom_iam_openid_connect_provider_url
  custom_iam_openid_connect_provider_arn = each.value.custom_iam_openid_connect_provider_arn
  allow_role_self_assume                 = each.value.allow_role_self_assume
  allow_third_party_assume_role          = each.value.allow_third_party_assume_role
  assume_third_party_condition_values    = each.value.assume_third_party_condition_values
  inline_policy                          = each.value.inline_policy
  policy_arns                            = each.value.policy_arns

  scope            = join("-", compact([var.prefix, var.environment, var.component]))
  namespace        = each.value.namespace
  application_name = each.value.application_name
}
