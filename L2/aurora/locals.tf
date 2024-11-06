data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}


locals {
  engine_version_list = split(".", var.engine_version)
  major_version       = element(local.engine_version_list, 0)
  minor_version       = element(local.engine_version_list, 1)

  db_credentials_secrets = [
    for secret in var.db_credentials_secrets : "/${var.environment}/${var.component}/platform/aurora/${secret}"
  ]

  max_conn = {
    "db.r6g.8xlarge" = 5000
    "db.r6g.4xlarge" = 5000
    "db.r6g.2xlarge" = 5000
    "db.r6g.xlarge"  = 3479
    "db.r6g.large"   = 1722
    "db.r5.24xlarge" = 5000
    "db.r5.16xlarge" = 5000
    "db.r5.12xlarge" = 5000
    "db.r5.8xlarge"  = 5000
    "db.r5.4xlarge"  = 5000
    "db.r5.2xlarge"  = 5000
    "db.r5.xlarge"   = 3300
    "db.r5.large"    = 1600
    "db.r4.16xlarge" = 5000
    "db.r4.8xlarge"  = 5000
    "db.r4.4xlarge"  = 5000
    "db.r4.2xlarge"  = 5000
    "db.r4.xlarge"   = 3200
    "db.r4.large"    = 1600
    "db.t4g.large"   = 844
    "db.t4g.medium"  = 405
    "db.t4g.small"   = 171
    "db.t3.large"    = 844
    "db.t3.medium"   = 420
    "db.t3.small"    = 171
  }
}
