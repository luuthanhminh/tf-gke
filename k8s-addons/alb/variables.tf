variable "region" {
  default = "ap-southeast-1"
}

variable "vpc_id" {
  default = ""
}

variable "eks_cluster_name" {
  default = "EKS-Cluster"
}

variable "cluster_version" {
  default = ""
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {}
}

# alb-ingress

variable "enabled" {
  type    = bool
  default = true
}

# Helm

variable "helm_chart_name" {
  default = "aws-load-balancer-controller"
}

variable "helm_chart_version" {
  default = "1.4.2"
}

variable "helm_release_name" {
  default = "aws-alb-controller"
}

variable "helm_repo_url" {
  default = "https://aws.github.io/eks-charts"
}

# K8S

variable "k8s_namespace" {
  default     = "kube-system"
  description = "The k8s namespace in which the alb-ingress service account has been created"
}

variable "k8s_service_account_name" {
  default     = "aws-alb-controller"
  description = "The k8s alb-ingress service account name"
}

variable "settings" {
  type        = map(any)
  description = "Additional settings which will be passed to the Helm chart values, see https://hub.helm.sh/charts/incubator/aws-alb-ingress-controller"
  default = {
    "enableWaf"   = false,
    "enableWafv2" = false
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
