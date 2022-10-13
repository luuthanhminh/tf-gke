variable "project" {
  default = "radicalpay"
}

variable "region" {
  default = "ap-southeast-1"
}

variable "environment" {
  default = "dev"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "eks_cluster_name" {
  default = "EKS-Cluster"
}

variable "cluster_version" {
  default = ""
}

# argocd-ingress

variable "enabled" {
  type    = bool
  default = true
}

# Helm
variable "helm_chart_name" {
  default = "argo-cd"
}

variable "helm_chart_version" {
  default = "5.5.5"
}

variable "helm_release_name" {
  default = "argocd"
}

variable "helm_repo_url" {
  default = "https://argoproj.github.io/argo-helm"
}

# K8S

variable "k8s_namespace" {
  default     = "argocd"
  description = "The k8s namespace in which the alb-ingress service account has been created"
}

variable "settings" {
  type        = map(any)
  description = "Additional settings which will be passed to the Helm chart values, see https://hub.helm.sh/charts/incubator/aws-alb-ingress-controller"
  default     = {}
}

variable "server_extraArgs" {
  type = list(any)
  default = []
}

variable "node_selector" {
  type = map(any)
  default = {
    "node_pool" = "pool-addons"
  }
}
