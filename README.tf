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
  region = "ap-south-1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "jenkins-eks"
  kubernetes_version = "1.33"

  vpc_id = "YOUR_VPC_ID"

  subnet_ids = [
    "YOUR_SUBNET_1",
    "YOUR_SUBNET_2"
  ]

  eks_managed_node_groups = {
    workers = {
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }

  tags = {
    Environment = "Dev"
    Terraform   = "true"
  }
}
