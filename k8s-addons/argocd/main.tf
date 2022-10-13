resource "helm_release" "argocd" {
  count            = var.enabled ? 1 : 0
  name             = var.helm_release_name
  repository       = var.helm_repo_url
  chart            = var.helm_chart_name
  namespace        = var.k8s_namespace
  create_namespace = true
  version          = var.helm_chart_version

  dynamic "set" {
    for_each = var.settings

    content {
      name  = set.key
      value = set.value
    }
  }
  set {
    name  = "server.extraArgs[0]"
    value = "--insecure"
  }
  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "controller.nodeSelector.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.node_selector
    
    content {
      name  = "server.nodeSelector.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "redis.nodeSelector.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "dex.nodeSelector.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "applicationSet.nodeSelector.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "repoServer.nodeSelector.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "notifications.nodeSelector.${set.key}"
      value = set.value
    }
  }
}
