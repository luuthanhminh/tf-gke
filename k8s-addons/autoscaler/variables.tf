variable "region" {
  default = "ap-southeast-1"
}

variable "eks_cluster_name" {
  default = "EKS-Cluster"
}

# cluster-autoscaler

variable "enabled" {
  type        = bool
  default     = true
  description = "Variable indicating whether deployment is enabled"
}

# Helm

variable "helm_chart_name" {
  type        = string
  default     = "cluster-autoscaler"
  description = "Helm chart name to be installed"
}

variable "helm_chart_version" {
  type        = string
  default     = "9.19.1"
  description = "Version of the Helm chart"
}

variable "helm_release_name" {
  type        = string
  default     = "cluster-autoscaler"
  description = "Helm release name"
}

variable "helm_repo_url" {
  type        = string
  default     = "https://kubernetes.github.io/autoscaler"
  description = "Helm repository"
}

# K8s

variable "k8s_namespace" {
  type        = string
  default     = "cluster-autoscaler"
  description = "The K8s namespace in which the node-problem-detector service account has been created"
}

variable "k8s_service_account_name" {
  default     = "cluster-autoscaler"
  description = "The k8s cluster-autoscaler service account name"
}

variable "settings" {
  type = map(any)
  default = {}
  description = "Additional settings which will be passed to the Helm chart values, see https://hub.helm.sh/charts/stable/cluster-autoscaler"
}

variable "extra_args" {
  type = map(any)
  default = {
    "aws-use-static-instance-list" = true,
    "logtostderr"                  = true,
    "stderrthreshold"              = "info",
    "v"                            = 4,
    "regional"                     = true,
    "balance-similar-node-groups"  = true
  }
}

variable "extra_env" {
  type = map(any)
  default = {
    "AWS_STS_REGIONAL_ENDPOINTS" = "regional"
  }
}

variable "node_selector" {
  type = map(any)
  default = {
    "nodegrouptype" = "addons"
  }
}

variable "cluster_identity_oidc_issuer" {
  default = ""
}
