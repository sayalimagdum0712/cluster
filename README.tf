terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "jenkins-eks"
  kubernetes_version = "1.32"

  vpc_id = "vpc-011f769ddd8a691a6"

  subnet_ids = [
    "subnet-0e623ba300cc8cd35",
    "subnet-0b94579a9899ae85f"
  ]

  eks_managed_node_groups = {
    workers = {
      instance_types = ["t3.medium"]

      desired_size = 2
      min_size     = 1
      max_size     = 3
    }
  }

  tags = {
    Environment = "Dev"
    Terraform   = "true"
  }
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
