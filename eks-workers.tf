resource "aws_eks_node_group" "test" {
  cluster_name    = aws_eks_cluster.test.name
  node_group_name = "test"
  node_role_arn   = aws_iam_role.eks_worker_node.arn
  subnet_ids      = module.vpc.private_subnets

  instance_types = var.eks_workers_node_types

  scaling_config {
    desired_size = var.desired_workers
    max_size     = var.max_workers
    min_size     = var.min_workers
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_cni_policy,
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_worker_node_ecr_registry_readonly
  ]
}

resource "aws_iam_role" "eks_worker_node" {
  name = "eks-worker-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_worker_node.name
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_worker_node.name
}
resource "aws_iam_role_policy_attachment" "eks_worker_node_ecr_registry_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks_worker_node.name
}

