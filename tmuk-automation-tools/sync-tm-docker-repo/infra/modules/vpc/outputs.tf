output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "private_subnets_ids" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}

output "public_subnets_ids" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}
