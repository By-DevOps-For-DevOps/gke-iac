locals {
  cluster_type           = "${var.gcp_project_id}-ap-private-sa"
  network_name           = "${local.cluster_type}-network"
  subnet_name            = "${local.cluster_type}-subnet"
  master_auth_subnetwork = "${local.cluster_type}-master-subnet"
  pods_range_name        = "ip-range-pods-${local.cluster_type}"
  svc_range_name         = "ip-range-svc-${local.cluster_type}"
  subnet_names = [
    for subnet_self_link in module.gcp-network.subnets_self_links :
    split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]
  ]
}

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google"
  version                         = "v27.0.0"
  kubernetes_version              = "1.27.2-gke.1200"
  project_id                      = var.gcp_project_id
  name                            = "${local.cluster_type}-cluster"
  regional                        = false
  zones                           = var.gcp_zones
  network                         = module.gcp-network.network_name
  subnetwork                      = local.subnet_names[index(module.gcp-network.subnets_names, local.subnet_name)]
  ip_range_pods                   = local.pods_range_name
  ip_range_services               = local.svc_range_name
  release_channel                 = "REGULAR"
  enable_vertical_pod_autoscaling = false
  service_account                 = "${var.gcp_project_id}@${var.gcp_project_id}.iam.gserviceaccount.com"
  create_service_account          = false
  #  enable_private_endpoint         = true
  #  enable_private_nodes            = true
  #  master_ipv4_cidr_block          = "172.16.0.0/28"

  master_authorized_networks = [
    {
      cidr_block   = "10.60.0.0/17"
      display_name = "VPC"
    },
    {
      cidr_block   = "148.192.98.38/32"
      display_name = "Ops's home IP"
    }
  ]
}
