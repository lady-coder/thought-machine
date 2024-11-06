resource "aws_ecr_repository" "this" {
  for_each             = setunion(toset(var.ecr_repositories), toset(var.pullthroughcache_repositories))
  name                 = each.value
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = var.kms_cmk_ecr
  }
}

resource "aws_ecr_lifecycle_policy" "this" {
  for_each   = toset(values(aws_ecr_repository.this)[*].name)
  repository = each.value

  policy = <<EOF
{
  "rules": [
      {
        "rulePriority": 1,
        "description": "Expire untagged images older than 2 days",
        "selection": {
          "tagStatus": "untagged",
          "countType": "sinceImagePushed",
          "countUnit": "days",
          "countNumber": 2
        },
        "action": {
          "type": "expire"
        }
      }
    ]
}
EOF
}

resource "aws_ecr_registry_policy" "this" {
  count = length(var.pullthroughcache_repositories) > 0 ? 1 : 0

  policy = data.aws_iam_policy_document.pullthroughcache_policy.json
}

resource "aws_ecr_pull_through_cache_rule" "ecr_public" {
  count = length(var.pullthroughcache_repositories) > 0 ? 1 : 0

  ecr_repository_prefix = "ecr-public"
  upstream_registry_url = "public.ecr.aws"
}

resource "aws_ecr_repository_policy" "pullthroughcache_ecr_sharing" {
  for_each   = toset(var.pullthroughcache_repositories)
  repository = "ecr-public/${each.key}"
  policy     = data.aws_iam_policy_document.pullthroughcache_ecr_sharing.json
}

resource "aws_ecr_repository_policy" "pullpush" {
  for_each   = toset(var.ecr_repositories)
  repository = aws_ecr_repository.this[each.key].name
  policy     = data.aws_iam_policy_document.pullpush_policy.json
}
