resource "helm_release" "alb_ingress" {
  count            = var.enabled ? 1 : 0
  name             = var.helm_release_name
  repository       = var.helm_repo_url
  chart            = var.helm_chart_name
  namespace        = var.k8s_namespace
  create_namespace = true
  version          = var.helm_chart_version

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = var.k8s_service_account_name
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb_ingress[0].arn
  }

  dynamic "set" {
    for_each = var.settings

    content {
      name  = set.key
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "nodeSelector.${set.key}"
      value = set.value
    }
  }
}
