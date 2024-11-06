resource "aws_codeartifact_domain" "this" {
  domain         = var.codeartifact_domain_name
  encryption_key = var.codeartifact_cmk_arn
}

resource "aws_codeartifact_repository" "this" {
  repository = var.codeartifact_repository_name
  domain     = aws_codeartifact_domain.this.domain

  upstream {
    repository_name = aws_codeartifact_repository.gradle_upstream_repo.repository
  }
  upstream {
    repository_name = aws_codeartifact_repository.maven_upstream_repo.repository
  }
}

# CodeArtifact Repositoris acting as a proxy to the public repos.
# When you request a package from the CodeArtifact repository that's not already present in the repository,
# the package can be fetched from the external connection.
resource "aws_codeartifact_repository" "gradle_upstream_repo" {
  repository  = var.codeartifact_gradle_repository_name
  domain      = aws_codeartifact_domain.this.domain
  description = "Provides Maven artifacts from Gradle plugins."

  external_connections {
    external_connection_name = "public:maven-gradleplugins"
  }
}

resource "aws_codeartifact_repository" "maven_upstream_repo" {
  repository  = var.codeartifact_maven_repository_name
  domain      = aws_codeartifact_domain.this.domain
  description = "Provides Maven artifacts from Maven Central Repository."

  external_connections {
    external_connection_name = "public:maven-central"
  }
}
