resource "aws_acm_certificate" "cert" {
  for_each = toset(var.domain_names)

  domain_name       = each.value
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  for_each                = aws_acm_certificate.cert
  certificate_arn         = each.value.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}
