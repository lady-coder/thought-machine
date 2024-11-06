module "billing_alert" {
  #checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source  = "spacelift.io/gft-blx/billing-alerts/aws"
  version = "1.1.1"
  providers = {
    aws.billing = aws.billing
  }

  environment       = var.environment
  subscriber_emails = var.billing_alert_subscriber_emails
}
