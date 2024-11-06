terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.36.0"
    }
  }
  required_version = "~> 1.5.0"
}

provider "github" {
  owner = var.owner

  app_auth {}
  # https://github.com/integrations/terraform-provider-github/pull/907
  write_delay_ms = 10 # sleep for 10ms in between requests
}
