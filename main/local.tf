locals {
  project = "${var.project}-${var.environment}"
  prefix = "${var.project}-${var.environment}-${var.region}"

  tags = merge(var.tags, {
    project      = var.project
    env          = var.environment
    region       = var.region
    provision_by = "terraform"
  })

  ip_range_services_name = "${local.prefix}-gke-service-range"

  subnet_tags = merge(local.tags, var.subnet_tags, {})

  secondary_subnets = [
    {
      range_name    = "${local.prefix}-default"
      ip_cidr_range = var.default_subnet
    },
    {
      range_name    = "${local.prefix}-dmz"
      ip_cidr_range = var.dmz_subnet
    },
    {
      range_name    = "${local.prefix}-cde"
      ip_cidr_range = var.cde_subnet
    },
    {
      range_name    = "${local.prefix}-merchant"
      ip_cidr_range = var.merchant_subnet
    },
    {
      range_name    = "${local.prefix}-backend"
      ip_cidr_range = var.backend_subnet
    },
    {
      range_name    = "${local.prefix}-monitor"
      ip_cidr_range = var.monitor_subnet
    },
    {
      range_name    = "${local.prefix}-addons"
      ip_cidr_range = var.addons_subnet
    },
    {
      range_name    = local.ip_range_services_name
      ip_cidr_range = "172.31.0.0/16"
    }
  ]

  network_routes = [
    {
      name              = "${local.prefix}-egress-inet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    },
    {
      name              = "${local.prefix}-cde-proxy"
      description       = "route through proxy to reach app"
      destination_range = "10.50.10.0/24"
      tags              = "app-proxy"
      next_hop_ip       = "10.10.40.10"
    },
  ]
}

output "subnets" {
  value = local.secondary_subnets
}
