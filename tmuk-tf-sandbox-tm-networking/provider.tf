provider "spacelift" {}

provider "aws" {
  region = var.region

  default_tags {
    tags = merge(
      var.L4_tags,
      {
        "blx:environment" = var.environment
      }
    )
  }
}
