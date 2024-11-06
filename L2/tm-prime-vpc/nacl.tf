resource "aws_network_acl" "default" {
  #checkov:skip=CKV2_AWS_1:Ensure that all NACL are attached to subnets
  vpc_id     = aws_vpc.this.id
  subnet_ids = concat(aws_subnet.public.*.id, aws_subnet.private_api.*.id, aws_subnet.msk.*.id, aws_subnet.db.*.id, aws_subnet.endpoints.*.id, aws_subnet.private.*.id)
  tags = {
    "Name" = "${var.environment}-${var.component}-all-nacl"
  }
}

resource "aws_network_acl_rule" "all_inbound" {
  network_acl_id = aws_network_acl.default.id
  rule_number    = 100
  protocol       = "all"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

resource "aws_network_acl_rule" "all_outbound" {
  network_acl_id = aws_network_acl.default.id
  rule_number    = 100
  protocol       = "all"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}
