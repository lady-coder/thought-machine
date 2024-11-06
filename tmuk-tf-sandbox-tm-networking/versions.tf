terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.17.0"
    }
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 0.1.30"
    }
  }

  required_version = ">= 1.5.7"
}
