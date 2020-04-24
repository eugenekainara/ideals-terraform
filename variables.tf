variable "main_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.16.0.0/16"
//  10.16.0.0-10.16.47.255 for public subnets
//  10.16.48.0-10.16.95.255 for private subnets
//  10.16.96.0-10.16.255.255 not used. could be used to separate RDS/Redshift/other subnets
}

variable "public_subnets" {
  type = list(string)
  default = ["10.16.0.0/20","10.16.16.0/20","10.16.32.0/20"]
}
variable "private_subnets" {
  type = list(string)
  default = ["10.16.48.0/20","10.16.64.0/20","10.16.80.0/20"]
}

variable "eks_cluster_name" {
  type = string
  default = "test"
}
variable "eks_workers_node_types" {
  type = list(string)
  default = ["t3.micro"]
}

variable "min_workers" {
  type = string
  default = "2"
}
variable "max_workers" {
  type = string
  default = "2"
}
variable "desired_workers" {
  type = string
  default = "2"
}
