output "waf_arn" {
  value = module.waf.waf_arn
}

output "certificate_arn" {
  value = element(values(aws_acm_certificate.cert)[*].arn, 0)
}

output "alb_security_group_id" {
  value = aws_security_group.this.id
}
