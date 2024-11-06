output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}

output "private_api_subnets_ids" {
  description = "List of IDs of private-api subnets"
  value       = aws_subnet.private_api.*.id
}

output "db_subnets_ids" {
  description = "List of IDs of db subnets"
  value       = aws_subnet.db.*.id
}

output "msk_subnets_ids" {
  description = "List of IDs of msk subnets"
  value       = aws_subnet.msk.*.id
}

output "endpoints_subnets_ids" {
  description = "List of IDs of endpoints subnets"
  value       = aws_subnet.endpoints.*.id
}

output "private_route53_zoneid" {
  value = aws_route53_zone.private.*.zone_id
}

output "public_route53_zoneid" {
  value = aws_route53_zone.public.*.zone_id
}
