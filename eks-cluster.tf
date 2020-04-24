resource "aws_eks_cluster" "test" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_policy.arn

  version = "1.15"
  vpc_config {
    subnet_ids = module.vpc.private_subnets
    endpoint_private_access = true
    endpoint_public_access = true
    security_group_ids = [module.security_group_eks.this_security_group_id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy
  ]
}
resource "aws_iam_role" "eks_policy" {
  name = "eks-admin-role"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_policy.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_policy.name
}

module "security_group_eks" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.8.0"

  name        = "test-eks-sg"
  description = "For managing connectivity to EKS"
  vpc_id      = module.vpc.vpc_id

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]
}
