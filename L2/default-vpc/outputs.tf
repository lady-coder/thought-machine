output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}

output "protected_subnets_ids" {
  description = "List of IDs of protected subnets"
  value       = aws_subnet.protected.*.id
}

output "public_subnets_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "tgw_subnets_ids" {
  description = "List of IDs of tgw subnets"
  value       = aws_subnet.tgw.*.id
}

output "private_route53_zoneid" {
  value = aws_route53_zone.private.*.zone_id
}

output "public_route53_zoneid" {
  value = aws_route53_zone.public.*.zone_id
}
