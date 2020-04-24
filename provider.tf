provider "aws" {
  version = "~> 2.0"
  region  = var.main_region
  // local AWS cli profile where all resources should be created
  profile = "default"
}

data "aws_availability_zones" "az_available" {}

provider "kubernetes" {
  version = "~> 1.11"
  load_config_file = false

  host = aws_eks_cluster.test.endpoint
  token = data.aws_eks_cluster_auth.eks.token

  cluster_ca_certificate = base64decode(aws_eks_cluster.test.certificate_authority.0.data)

}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.test.name
}

