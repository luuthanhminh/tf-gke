variable "project_id" {
  default = "sample-dev"
}

variable "project" {
  default = "sample"
}

variable "region" {
  default = "asia-southeast1"
}

variable "environment" {
  default = "dev"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "subnet_tags" {
  type    = map(any)
  default = {}
}

variable "vpc_cidr" {
  default = "172.20.0.0/16"
}

variable "sql_authorized_networks" {
  default = "42.113.165.228/32"
}

variable "azs" {
  # default = ["asia-southeast1-b", "asia-southeast1-c"]
  default = ["asia-southeast1-b"]
}

variable "gke_master_cidr" {
  default = "172.16.244.0/28"
}

variable "default_subnet" {
  default = "172.16.112.0/20"
}

variable "dmz_subnet" {
  default = "172.16.0.0/20"
}

variable "cde_subnet" {
  default = "172.16.16.0/20"
}

variable "merchant_subnet" {
  default = "172.16.32.0/20"
}

variable "backend_subnet" {
  default = "172.16.48.0/20"
}

variable "monitor_subnet" {
  default = "172.16.208.0/20"
}

variable "addons_subnet" {
  default = "172.16.224.0/20"
}

variable "machine_type_dmz" {
  default = "n2d-standard-2"
}

variable "machine_type_cde" {
  default = "n2d-standard-2"
}

variable "machine_type_merchant" {
  default = "n2d-standard-2"
}

variable "machine_type_backend" {
  default = "n2d-standard-2"
}

variable "machine_type_monitor" {
  default = "n2d-standard-2"
}

variable "machine_type_addons" {
  default = "n2d-standard-4"
}

variable "machine_type_redis" {
  default = "n2d-standard-2"
}

variable "machine_type_kafka" {
  default = "n2d-standard-2"
}
