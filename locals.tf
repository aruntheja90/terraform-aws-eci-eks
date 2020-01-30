locals {
  cluster_tags = {
    Description   = "EKS cluster for ECI applications"
    Environment   = "${var.environment}"
    ManagedBy     = "Terraform"
    ProductDomain = "eci"
    Tier          = "public,app"
  }
}