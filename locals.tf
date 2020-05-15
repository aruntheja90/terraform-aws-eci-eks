locals {
  cluster_tags = {
    Description   = "EKS cluster for ECI applications"
    Environment   = "${var.environment}"
    ManagedBy     = "terraform"
    ProductDomain = "eci"
    Tier          = "public,app"
    Team          = "${var.team}"
  }
}
