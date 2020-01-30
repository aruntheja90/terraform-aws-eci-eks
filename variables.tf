variable "environment" {
  description = "Name of AWS environment this EKS cluster belongs to. This should be the same with its VPC name."
  type        = "string"
}

variable "product_domain" {
  description = "Name of product domain"
  type        = "string"
}

variable "cluster_name" {
  type        = "string"
  description = "Name of this EKS cluster."
}

variable "vpc_id" {
  description = "VPC ID of EKS cluster."
  type        = "string"
}

variable "subnets" {
  description = "App subnets from the vpc for EKS"
  type        = "list"
}

variable "cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  default     = "1.12"
}

variable "map_roles" {
  description = "List of IAM roles adding to control EKS cluster."
  type        = "list"
}

# we still need map roles count because of a terraform bug
# https://github.com/hashicorp/terraform/issues/12570
# explanation: when planning an EKS module which references map_roles items that have not
# been applied yet, length(map_roles) will become "computed" and count variables do not accept
# "computed" variable types
variable "map_roles_count" {
  description = "describe your variable"
  type        = "string"
}

variable "workers_group_defaults_create_key_pair" {
  description = "Indicates whether to also create a key pair for the worker group defaults. This should be false for staging and production environments because there should not be ssh keys for these environments"
  type        = "string"
  default     = "false"
}

variable "workers_group_defaults" {
  description = "Default setting for ASG that running EKS worker nodes."
  type        = "map"

  default = {
    asg_desired_capacity = 2
    root_volume_size     = "20"
    root_encrypted       = true
  }
}

variable "workers_additional_policies" {
  description = "Additional policies to attach to worker nodes."
  type        = "list"
  default     = []
}

variable "workers_additional_policies_count" {
  description = "Number of additional policies attach to worker nodes."
  default     = 0
}

variable "write_kubeconfig" {
  description = "Whether to write a Kubectl config file containing the cluster configuration. Saved to `config_output_path`."
  default     = true
}

variable "write_aws_auth_config" {
  description = "Whether to write the aws-auth configmap file."
  default     = true
}

variable "worker_additional_security_group_ids" {
  description = "Additional security groups to add to the workers."
  type        = "list"
  default     = []
}

variable "worker_groups" {
  description = "Values to overwrite for default settings of workers_group_defaults."
  type        = "list"
  default     = []
}

variable "worker_group_count" {
  description = "Values to overwrite for default settings of workers_group_defaults."
  type        = "string"
  default     = "0"
}

variable "worker_groups_launch_template" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Templates. See workers_group_defaults for valid keys."
  type        = "list"
  default     = []
}

variable "worker_group_launch_template_count" {
  description = "The number of maps contained within the worker_groups_launch_template list."
  type        = "string"
  default     = "0"
}

# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/103
# Remember to remove this part once we use newer version of EKS module, which already fixed this.
variable "enable_service_link_role" {
  description = "This will need to be true, if current AWS account never create any ELB."
  default     = false
}
