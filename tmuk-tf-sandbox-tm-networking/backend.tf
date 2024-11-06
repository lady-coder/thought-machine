terraform {
  backend "s3" {
    bucket         = "sandbox-051939627954-tm-networking-state-s3"
    dynamodb_table = "sandbox-tm-networking-lock-table"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
  }
}
