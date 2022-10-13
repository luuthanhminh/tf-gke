project_id  = "sample-dev"
project     = "sample"
environment = "dev"
region      = "asia-southeast1"
tags        = {}

vpc_cidr        = "172.20.0.0/16"
azs             = ["asia-southeast1-b", "asia-southeast1-c"]
default_subnet  = "172.16.112.0/20"
dmz_subnet      = "172.16.0.0/20"
cde_subnet      = "172.16.16.0/20"
merchant_subnet = "172.16.32.0/20"
backend_subnet  = "172.16.48.0/20"
monitor_subnet  = "172.16.208.0/20"
addons_subnet   = "172.16.224.0/20"
