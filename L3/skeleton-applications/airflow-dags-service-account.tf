module "airflow_dags_account_service_irsa_role" {
  source  = "spacelift.io/gft-blx/eks-irsa-role/aws"
  version = "3.0.3"

  iam_openid_connect_provider_url = var.iam_openid_connect_provider_url
  iam_openid_connect_provider_arn = var.iam_openid_connect_provider_arn
  inline_policy                   = data.aws_iam_policy_document.this.json

  scope            = "${var.environment}-${var.component}"
  namespace        = "airflow-dags"
  application_name = "airflow-dags"

}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "AirflowBucketReadUpdate"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:AbortMultipartUpload",
      "s3:ListBucket",
      "s3:PutObjectTagging",
      "s3:ListMultipartUploadParts",
      "s3:DeleteObject"
    ]
    resources = [
      "${var.datatech_airflowdags_bucket_arn}",
      "${var.datatech_airflowdags_bucket_arn}/*"
    ]
  }
}
