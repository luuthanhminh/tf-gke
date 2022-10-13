resource "helm_release" "cluster_autoscaler" {
  count      = var.enabled ? 1 : 0
  chart      = var.helm_chart_name
  namespace  = var.k8s_namespace
  name       = var.helm_release_name
  version    = var.helm_chart_version
  repository = var.helm_repo_url

  set {
    name  = "awsRegion"
    value = var.region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = var.k8s_service_account_name
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cluster_autoscaler[0].arn
  }

  dynamic "set" {
    for_each = var.settings
    content {
      name  = set.key
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.extra_args

    content {
      name  = "extraArgs.${set.key}"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.extra_env

    content {
      name  = "extraEnv.${set.key}"
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
