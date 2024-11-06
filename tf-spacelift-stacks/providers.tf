terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.2.0"
    }
  }
  required_version = "1.5.7"
}

provider "spacelift" {}
