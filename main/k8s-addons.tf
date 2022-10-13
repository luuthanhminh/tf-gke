data "google_client_config" "default" {}

provider "helm" {
  # kubernetes {
  #   host                   = "https://${module.gke.endpoint}"
  #   token                  = data.google_client_config.default.access_token
  #   cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  # }
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "argocd" {
  source = "../../k8s-addons/argocd"

  eks_cluster_name = local.prefix
  node_selector = {
    "node_pool" = "pool-addons"
  }

  depends_on = [
    module.gke
  ]
}

module "ingress_nginx" {
  source = "../../k8s-addons/ingress-nginx"
  node_selector = {
    "node_pool" = "pool-addons"
  }

  depends_on = [
    module.gke
  ]
}

