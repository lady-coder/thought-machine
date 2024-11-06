data "aws_iam_policy_document" "assume_role" {
  statement {
    sid = "EKSAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      identifiers = [
        "eks.amazonaws.com"
      ]

      type = "Service"
    }
  }
}

resource "aws_iam_role" "control_plane_role" {
  name                  = lower("system-eks-${var.cluster_name}-control-plane-role")
  assume_role_policy    = data.aws_iam_policy_document.assume_role.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.control_plane_role.name
}

resource "aws_iam_role_policy_attachment" "service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.control_plane_role.name
}
