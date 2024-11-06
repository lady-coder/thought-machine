
resource "aws_route53_record" "this" {
  for_each = merge([
    for cert in aws_acm_certificate.cert : {
      for dvo in cert.domain_validation_options : dvo.domain_name => {
        name   = dvo.resource_record_name
        record = dvo.resource_record_value
        type   = dvo.resource_record_type
      }
    }
  ]...)

  allow_overwrite = true
  zone_id         = var.public_zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = "60"
  records         = [each.value.record]
}
