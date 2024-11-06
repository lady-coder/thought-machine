variable "codeartifact_domain_name" {
  description = "A domain is a CodeArtifact-specific construct that allows grouping and managing multiple CodeArtifact repositories owned by a single organization across multiple AWS accounts."
  type        = string
}

variable "codeartifact_cmk_arn" {
  description = "ARN of KMS CMK used to encrypt the Codeartifact domain"
  type        = string
}

variable "codeartifact_repository_name" {
  description = "A CodeArtifact repository contains a set of package versions, each of which maps to a set of assets. Repositories are polyglot - a single repository can contain packages of any supported type."
  type        = string
}

variable "codeartifact_maven_repository_name" {
  description = "Default codeartifact upstream maven repository"
  type        = string
  default     = "maven-central-store"
}

variable "codeartifact_gradle_repository_name" {
  description = "Default codeartifact upstream gradle repository"
  type        = string
  default     = "gradle-plugins-store"
}

variable "codeartifact_iam_principals" {
  description = "The IAM Roles that has list/read/publish permissions to the CodeArtifact domain and repository."
  type        = list(string)
  default     = []
}
