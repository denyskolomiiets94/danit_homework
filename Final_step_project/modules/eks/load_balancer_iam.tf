resource "aws_iam_role" "aws_load_balancer_controller" {
  name = "AmazonEKSLoadBalancerControllerRole-${var.cluster_name}"
  tags = {
  "alpha.eksctl.io/cluster-name"                = var.cluster_name
  "alpha.eksctl.io/eksctl-version"              = "0.231.0"
  "alpha.eksctl.io/iamserviceaccount-name"      = "kube-system/aws-load-balancer-controller"
  "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = var.cluster_name
}
  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = aws_iam_openid_connect_provider.eks.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "${trimprefix(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://")}:aud" = "sts.amazonaws.com"
            "${trimprefix(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name = "AWSLoadBalancerControllerIAMPolicy"

  policy = file("${path.module}/../../iam-policy.json")
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}