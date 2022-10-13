module "gke" {
  source                    = "terraform-google-modules/kubernetes-engine/google"
  project_id                = var.project_id
  name                      = "${local.prefix}-cluster"
  regional                  = true
  region                    = var.region
  zones                     = var.azs
  network                   = module.vpc.network_name
  ip_range_pods             = "${local.prefix}-default"
  ip_range_services         = local.ip_range_services_name
  subnetwork                = module.vpc.subnets_names[0]
  create_service_account    = true
  default_max_pods_per_node = 20
  remove_default_node_pool  = true
  grant_registry_access     = true
  # enable_private_endpoint   = true
  # enable_private_nodes      = true
  # master_ipv4_cidr_block    = var.gke_master_cidr

  # master_authorized_networks = [
  #   {
  #     cidr_block   = var.vpc_cidr
  #     display_name = "VPC"
  #   },
  # ]

  node_pools = [
    {
      name            = "pool-dmz"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_dmz
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-dmz"
    },
    {
      name            = "pool-cde"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_cde
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-cde"
    },
    {
      name            = "pool-merchant"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_merchant
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-merchant"
    },
    {
      name            = "pool-backend"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_backend
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-backend"
    },
    {
      name            = "pool-monitor"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_monitor
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-monitor"
    },
    {
      name            = "pool-addons"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_addons
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-addons"
    },
    {
      name            = "pool-kafka"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_kafka
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-addons"
    },
    {
      name            = "pool-redis"
      min_count       = 1
      max_count       = 100
      local_ssd_count = 0
      disk_size_gb    = 50
      disk_type       = "pd-standard"
      machine_type    = var.machine_type_redis
      auto_repair     = true
      auto_upgrade    = true
      # service_account   = var.compute_engine_service_account
      preemptible       = false
      max_pods_per_node = 12
      ip_range_pods     = "${local.prefix}-addons"
    },
  ]
}
