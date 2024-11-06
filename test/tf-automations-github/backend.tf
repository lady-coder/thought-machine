terraform {
  backend "s3" {
    bucket         = "shared-service-336241431902-github-automations-state-s3"
    dynamodb_table = "shared-service-github-automations-lock-table"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
  }
}
