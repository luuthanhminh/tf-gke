resource "helm_release" "ingress_nginx" {
  count            = var.enabled ? 1 : 0
  name             = var.helm_release_name
  repository       = var.helm_repo_url
  chart            = "ingress-nginx"
  namespace        = var.k8s_namespace
  create_namespace = true
  version          = var.helm_chart_version
  timeout          = var.helm_timeout

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
      name  = "controller.nodeSelector.${set.key}"
      value = set.value
    }
  }
  dynamic "set" {
    for_each = var.node_selector

    content {
      name  = "defaultBackend.nodeSelector.${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = var.annotations

    content {
      name  = "controller.service.annotations.${replace(set.key, ".", "\\.")}"
      value = set.value
      type  = "string"
    }
  }
  dynamic "set" {
    for_each = var.annotations

    content {
      name  = "controller.service.internal.annotations.${replace(set.key, ".", "\\.")}"
      value = set.value
      type  = "string"
    }
  }

  dynamic "set" {
    for_each = var.internal_annotations
    content {
      name  = "controller.service.internal.annotations.${replace(set.key, ".", "\\.")}"
      value = set.value
      type  = "string"
    }
  }
}
