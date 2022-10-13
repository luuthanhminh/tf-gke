variable "PROJECT_ID" {
  default = "terraform"
}

variable "org" {
  default = ""
}

variable "tenant" {
  default = ""
}

variable "environment" {
  default = ""
}

variable "vpc_name" {
  default = ""
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {}
}

# nlb-ingress

variable "enabled" {
  type    = bool
  default = true
}

# Helm

variable "helm_chart_name" {
  default = "ingress-nginx"
}

variable "helm_chart_version" {
  default = "4.2.5"
}

variable "helm_release_name" {
  default = "ingress-nginx"
}

variable "helm_repo_url" {
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "helm_timeout" {
  default = 1800
}

# K8S

variable "k8s_namespace" {
  default     = "ingress-nginx"
  description = "The k8s namespace in which the nlb-ingress service account has been created"
}

variable "k8s_service_account_name" {
  default     = "ingress-nginx-controller"
  description = "The k8s nlb-ingress service account name"
}

variable "settings" {
  type        = map(any)
  description = "Additional settings which will be passed to the Helm chart values, see https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx#configuration"
  default = {}
}

variable "annotations" {
  type = map(any)
  default = {}
}

variable "internal_annotations" {
  type = map(any)
  default = {}
}

variable "node_selector" {
  type = map(any)
  default = {
    "node_pool" = "pool-addons"
  }
}

