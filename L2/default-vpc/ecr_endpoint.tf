resource "aws_security_group" "ecr_endpoint_sg" {
  name        = "${join("-", compact([var.prefix, var.environment, var.component]))}-ecr-endpoint-sg"
  description = "Security Group for ECR VPC Endpoint"
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" = "${join("-", compact([var.prefix, var.environment, var.component]))}-ecr-endpoint-sg"
  }
}

resource "aws_security_group_rule" "ecr_endpoint_ingress" {
  description       = "Security group rule for ecr endpoint"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecr_endpoint_sg.id
}

data "aws_region" "current" {}

resource "aws_vpc_endpoint" "ecr" {
  count               = var.enabled_vpc_endpoint ? 1 : 0
  vpc_id              = aws_vpc.this.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  subnet_ids          = aws_subnet.private[*].id
  security_group_ids  = [aws_security_group.ecr_endpoint_sg.id]
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  policy              = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

  tags = {
    "Name" = "${var.prefix}-${var.environment}-${var.component}-ecr-endpoint"
  }
}
