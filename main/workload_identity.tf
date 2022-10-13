module "workload_identity_merchant" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  project_id          = var.project_id
  name                = "${local.project}-merchant"
  use_existing_k8s_sa = false
  roles = ["roles/storage.objectCreator", "roles/storage.objectViewer", "roles/cloudsql.client", "roles/iam.serviceAccountTokenCreator"]
}

module "workload_identity_admin" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  project_id          = var.project_id
  name                = "${local.project}-admin"
  use_existing_k8s_sa = false
  roles = ["roles/cloudsql.client"]
}

module "workload_identity_payment" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  project_id          = var.project_id
  name                = "${local.project}-payment"
  use_existing_k8s_sa = false
  roles = ["roles/cloudsql.client"]
}

output "gcp_service_account_merchant" {
  value = module.workload_identity_merchant.gcp_service_account
}

output "gcp_service_account_admin" {
  value = module.workload_identity_admin.gcp_service_account
}

output "gcp_service_account_payment" {
  value = module.workload_identity_payment.gcp_service_account
}
