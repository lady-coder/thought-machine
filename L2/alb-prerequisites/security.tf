#tfsec:ignore:aws-vpc-no-public-ingress-sg
resource "aws_security_group" "this" {
  #checkov:skip=CKV2_AWS_5:"Ensure that Security Groups are attached to another resource"
  name        = "${join("-", compact([var.prefix, var.environment, var.component, var.context]))}-lb-sg"
  description = "Security group for ${var.prefix} ${var.environment} ${var.component} ${var.context} load balancer"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = flatten(
      [
        for port in var.ingress_ports : [
          for entry in var.allowed_source_ips : [
            {
              port        = port
              cidr_blocks = entry.cidr_blocks
              description = entry.description
            }
          ]
        ]
      ]
    )
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = "tcp"
      cidr_blocks = ingress.value["cidr_blocks"]
      description = "Allow ingress connection on port ${ingress.value["port"]} from ${ingress.value["description"]}"
    }
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = var.eks_workers_subnets_cidr_blocks
    description = "Allow outbound traffic to EKS target groups private subnets"
  }
}
