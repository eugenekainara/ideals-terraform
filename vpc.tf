module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 2.33.0"

  name = "test-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.az_available.names
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = false

  private_subnet_tags = merge(
          map("kubernetes.io/cluster/${var.eks_cluster_name}", "shared"),
  )
  public_subnet_tags = merge(
          map("kubernetes.io/role/elb",""),
          map("KubernetesCluster",var.eks_cluster_name)
  )

}
