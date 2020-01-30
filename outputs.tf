output "cluster_name" {
  depends_on = ["null_resource.wait_for_eks"]

  value = "${var.cluster_name}"
}

output "cluster_id" {
  depends_on = ["null_resource.wait_for_eks"]

  value = "${module.eks.cluster_id}"
}

output "cluster_endpoint" {
  depends_on = ["null_resource.wait_for_eks"]

  value = "${module.eks.cluster_endpoint}"
}

output "cluster_ca_certificate" {
  depends_on = ["null_resource.wait_for_eks"]

  value = "${base64decode(module.eks.cluster_certificate_authority_data)}"
}

output "worker_security_group_id" {
  depends_on = ["null_resource.wait_for_eks"]

  description = "Security group ID of EKS worker nodes. This is to permit all EKS worker nodes network access to RDS cluster"
  value       = "${module.eks.worker_security_group_id}"
}

output "worker_asg_ids" {
  depends_on = ["null_resource.wait_for_eks"]

  description = "IDs of the autoscaling groups containing workers"
  value       = ["${module.eks.workers_asg_names}"]
}

output "worker_asg_id_count" {
  depends_on = ["null_resource.wait_for_eks"]

  description = "Number of IDs of the autoscaling groups containing workers"
  value       = "${var.worker_group_count + var.worker_group_launch_template_count}"
}