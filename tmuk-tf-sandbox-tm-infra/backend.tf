terraform {
  backend "s3" {
    bucket         = "sandbox-051939627954-tm-infrastructure-state-s3"
    dynamodb_table = "sandbox-tm-infrastructure-lock-table"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
  }
}
