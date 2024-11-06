
#Common variables
region = "eu-central-1"
L4_tags = {
  "blx:created-by"      = "terraform"
  "blx:owner"           = "all"
  "blx:tag-version"     = "1"
  "blx:repository-name" = "tf-spacelift-prerequisites"
}
prefix      = ""
environment = "sandbox"

#Variables for Shared Services
shared_service_admin_role  = "arn:aws:iam::336241431902:role/aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_AdministratorAccess_824f48fbf5e79ff4"
shared_service_github_role = "arn:aws:iam::336241431902:role/shared-services-ci-github-actions-runners-eks-irsa-role"

platform_helm_chart_ecr_prefix = "platform/helm-charts"
platform_image_ecr_prefix      = "platform/images"
