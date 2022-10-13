locals {
  read_replica_ip_configuration = {
    ipv4_enabled       = true
    require_ssl        = false
    private_network    = null
    allocated_ip_range = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.sql_authorized_networks
      },
    ]
  }

  pg_ha_name = "${local.prefix}-pg"
  database_flags = var.database_flags
}

module "pg" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "12.0.0"

  name                 = local.pg_ha_name
  random_instance_name = true
  project_id           = var.project_id
  database_version     = "POSTGRES_14"
  region               = var.region

  // Master configurations
  tier                            = var.db_tier
  zone                            = var.azs[0]
  availability_type               = "REGIONAL"
  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  deletion_protection = false

  database_flags = local.database_flags

  user_labels = local.tags

  ip_configuration = {
    ipv4_enabled       = true
    require_ssl        = true
    private_network    = null
    allocated_ip_range = null
    authorized_networks = [
      {
        name  = "${var.project_id}-cidr"
        value = var.sql_authorized_networks
      },
    ]
  }

  backup_configuration = {
    enabled                        = true
    start_time                     = "20:55"
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = null
    retained_backups               = 365
    retention_unit                 = "COUNT"
  }

  // Read replica configurations
  read_replicas = [
    for index, az in var.azs :
    {
      name                  = index
      zone                  = az
      availability_type     = "REGIONAL"
      tier                  = var.db_tier
      ip_configuration      = local.read_replica_ip_configuration
      database_flags        = local.database_flags
      disk_autoresize       = null
      disk_autoresize_limit = null
      disk_size             = null
      disk_type             = "PD_HDD"
      user_labels           = local.tags
      encryption_key_name   = null
    }
  ]

  db_name      = local.pg_ha_name
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"

  additional_databases = [
    {
      name      = "${local.prefix}"
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
  ]

  # user_name     = "tftest"
  # user_password = "foobar"
}