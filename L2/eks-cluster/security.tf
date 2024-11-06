resource "aws_security_group" "control_plane_sg" {

  name   = lower("eks-${var.cluster_name}-cluster-sg")
  vpc_id = var.vpc_id

  # do not update this description, update causes k8s provider issue https://github.com/terraform-aws-modules/terraform-aws-eks/issues/2007
  description = "Security group for the cross-account elastic network interfaces that Amazon EKS creates to use to allow communication between your worker nodes and the Kubernetes control plane"
}

resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  security_group_id = aws_security_group.control_plane_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Outgoing traffic from EKS control plane to the world"
}

resource "aws_security_group_rule" "ingress_internal" {
  type              = "ingress"
  security_group_id = aws_security_group.control_plane_sg.id
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cird]
  description       = "Incoming traffic to API server port from VPC CIDR range only"
}

resource "aws_security_group_rule" "inbound_all_tcp_from_whitelisted_sg" {
  count                    = length(var.inbound_security_groups) > 0 ? length(var.inbound_security_groups) : 0
  description              = "Allow all TCP traffic for specific security groups"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = var.inbound_security_groups[count.index]
  security_group_id        = aws_security_group.control_plane_sg.id
}

resource "aws_security_group_rule" "inbound_all_tcp_from_cp_whitelisted_sg" {
  count             = length(var.control_plane_allowed_ip_ranges) > 0 ? length(var.control_plane_allowed_ip_ranges) : 0
  description       = "Allow all TCP traffic for specific IP ranges"
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.control_plane_allowed_ip_ranges[count.index]]
  security_group_id = aws_security_group.control_plane_sg.id
}
