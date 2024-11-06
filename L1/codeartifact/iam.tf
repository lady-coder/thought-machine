
data "aws_iam_policy_document" "default_repository_permissions" {
  statement {
    sid    = "RepoPermissions"
    effect = "Allow"
    actions = [
      "codeartifact:DescribePackageVersion",
      "codeartifact:DescribeRepository",
      "codeartifact:GetPackageVersionReadme",
      "codeartifact:GetRepositoryEndpoint",
      "codeartifact:ListPackages",
      "codeartifact:ListPackageVersionAssets",
      "codeartifact:ListPackageVersionDependencies",
      "codeartifact:ListPackageVersions",
      "codeartifact:PublishPackageVersion",
      "codeartifact:PutPackageMetadata",
      "codeartifact:ReadFromRepository",
    ]
    resources = [
      aws_codeartifact_repository.this.arn
    ]
    principals {
      type        = "AWS"
      identifiers = var.codeartifact_iam_principals
    }
  }
}

data "aws_iam_policy_document" "default_domain_permissions" {
  statement {
    sid    = "DomainPermissions"
    effect = "Allow"
    actions = [
      "codeartifact:CreateRepository",
      "codeartifact:DescribeDomain",
      "codeartifact:GetAuthorizationToken",
      "codeartifact:GetDomainPermissionsPolicy",
      "codeartifact:ListRepositoriesInDomain",
      "sts:GetServiceBearerToken"
    ]
    resources = [
      aws_codeartifact_domain.this.arn
    ]
    principals {
      type        = "AWS"
      identifiers = var.codeartifact_iam_principals
    }
  }
}


resource "aws_codeartifact_domain_permissions_policy" "default_permissions" {
  domain          = aws_codeartifact_domain.this.domain
  policy_document = data.aws_iam_policy_document.default_domain_permissions.json
}

resource "aws_codeartifact_repository_permissions_policy" "default_permissions" {
  repository      = aws_codeartifact_repository.this.repository
  domain          = aws_codeartifact_domain.this.domain
  policy_document = data.aws_iam_policy_document.default_repository_permissions.json
}