variable "gcp_project_id" {
  type        = string
  default     = "stage-v3"
  description = "The name of the Google Cloud Project where the cluster is to be provisioned"
}

variable "gcp_region" {
  type        = string
  default     = "asia-northeast1"
  description = "The name of the Google region where the cluster nodes are to be provisioned"
}

variable "gcp_zones" {
  type        = list(string)
  default     = ["asia-northeast1-a", "asia-northeast1-b"]
  description = "Available zones for zonal deployment"
}

variable "cluster_description" {
  type        = string
  default     = "This cluster is managed by GitLab"
  description = "A description for the cluster. We recommend adding the $CI_PROJECT_URL variable to describe where the cluster is configured."
}

variable "machine_type" {
  type        = string
  default     = "n1-standard-2"
  description = "The name of the machine type to use for the cluster nodes"
}

variable "node_count" {
  default     = 1
  description = "The number of cluster nodes"
}
