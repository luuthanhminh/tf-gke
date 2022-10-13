module "memstore" {
  source  = "terraform-google-modules/memorystore/google"
  version = "5.1.0"

  name = "${local.prefix}-redis"

  project                 = var.project_id
  region                  = var.region
  location_id             = var.azs[0]
  alternative_location_id = var.azs[1]
  enable_apis             = true
  auth_enabled            = true
  transit_encryption_mode = "SERVER_AUTHENTICATION"
  authorized_network      = module.vpc.network_id
  memory_size_gb          = 5

  read_replicas_mode = "READ_REPLICAS_ENABLED"
  replica_count = 2
  tier = "STANDARD_HA"
}
