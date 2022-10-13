resource "helm_release" "metrics_server" {
  count            = var.enabled ? 1 : 0
  chart            = var.helm_chart_name
  namespace        = var.k8s_namespace
  name             = var.helm_release_name
  version          = var.helm_chart_version
  repository       = var.helm_repo_url
  create_namespace = true

  set {
    name  = "apiService.create"
    value = true
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
    for_each = var.node_selector

    content {
      name  = "nodeSelector.${set.key}"
      value = set.value
    }
  }
}
