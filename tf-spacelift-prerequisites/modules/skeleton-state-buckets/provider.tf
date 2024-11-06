provider "aws" {
  region = var.region

  default_tags {
    tags = merge(
      var.L4_tags,
      var.L3_tags,
      {
        "blx:environment" = var.environment
      }
    )
  }
}
