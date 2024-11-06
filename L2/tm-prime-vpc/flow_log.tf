locals {
  subnet = concat(aws_subnet.private.*.id, aws_subnet.private_api.*.id, aws_subnet.msk.*.id, aws_subnet.db.*.id, aws_subnet.endpoints.*.id)
}

output "subnet_logs" {
  description = "List of all logs subnets"
  value       = local.subnet
}

resource "aws_flow_log" "rejected_private_traffic" {
  count                    = length(local.subnet)
  subnet_id                = local.subnet[count.index]
  traffic_type             = "REJECT"
  log_destination          = module.flow_log_bucket.bucket_arn
  log_destination_type     = "s3"
  max_aggregation_interval = var.max_aggregation_interval
}
