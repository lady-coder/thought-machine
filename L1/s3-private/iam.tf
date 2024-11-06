data "aws_iam_policy_document" "deny_unencrypted_operations" {
  statement {
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this.id}/*"
    ]
    condition {
      test     = "ForAnyValue:Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    condition {
      test     = "NumericLessThan"
      variable = "s3:TlsVersion"
      values   = ["1.2"]
    }
  }
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = [
    data.aws_iam_policy_document.deny_unencrypted_operations.json,
    var.extended_policy_json
  ]
}

resource "aws_s3_bucket_policy" "combined" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.combined.json
}
