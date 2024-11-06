# https://github.com/integrations/terraform-provider-github/issues/876#issuecomment-1303790559
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.36.0"
    }
  }
  required_version = "~> 1.5.0"
}
