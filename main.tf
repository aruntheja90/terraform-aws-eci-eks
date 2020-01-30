provider "aws" {
  version = ">= 2.6.0"
}

locals {
  common_tags = "${merge(
    map("Environment", var.environment),
    map("ProductDomain", var.product_domain),
    map("ManagedBy", "Terraform"))}"
}

# https://github.com/terraform-aws-modules/terraform-aws-eks/issues/103
# Remember to remove this part once we use newer version of EKS module, which already fixed this.
resource "aws_iam_service_linked_role" "elasticloadbalancing" {
  count = "${var.enable_service_link_role}"

  aws_service_name = "elasticloadbalancing.amazonaws.com"

  lifecycle {
    ignore_changes = ["aws_service_name"]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "4.0.2"

  cluster_name    = "${var.cluster_name}"
  cluster_version = "${var.cluster_version}"
  map_roles       = "${var.map_roles}"
  map_roles_count = "${var.map_roles_count}"
  subnets         = "${var.subnets}"
  tags            = "${local.cluster_tags}"
  vpc_id          = "${var.vpc_id}"

  worker_additional_security_group_ids = [
    "${var.worker_additional_security_group_ids}",
  ]

  worker_sg_ingress_from_port       = "0"
  workers_group_defaults            = "${var.workers_group_defaults}"
  workers_additional_policies       = "${var.workers_additional_policies}"
  workers_additional_policies_count = "${var.workers_additional_policies_count}"

  write_kubeconfig      = "${var.write_kubeconfig}"
  write_aws_auth_config = "${var.write_aws_auth_config}"

  worker_groups                      = "${var.worker_groups}"
  worker_group_count                 = "${var.worker_group_count}"
  worker_groups_launch_template      = "${var.worker_groups_launch_template}"
  worker_group_launch_template_count = "${var.worker_group_launch_template_count}"
}
