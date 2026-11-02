resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  namespace  = "kube-system"

  set = [
    {
      name  = "clusterName"
      value = data.aws_eks_cluster.main.name
    },
    {
      name  = "region"
      value = "eu-central-1"
    },
    {
      name  = "vpcId"
      value = data.aws_eks_cluster.main.vpc_config[0].vpc_id
    },
    {
      name  = "serviceAccount.create"
      value = "true"
    },
    {
      name  = "serviceAccount.name"
      value = "aws-load-balancer-controller"
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = "arn:aws:iam::943865900046:role/AmazonEKSLoadBalancerControllerRole-student-denys"
      type  = "string"
    }
  ]

  wait    = true
  timeout = 600
}