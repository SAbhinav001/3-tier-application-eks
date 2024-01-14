data "aws_availability_zones" "azs" {}

module "vpc" {
  source   = "../modules"
  vpc_name = "demo-vpc"
  vpc_cidr     = "10.0.0.0/16"

  eu_availability_zone = data.aws_availability_zones.azs.names

  cidr_public_subnet  = ["10.0.1.0/24", "10.0.2.0/24"]
  cidr_private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
  vpc_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }


  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.27"
  
  cluster_endpoint_public_access  = true


  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnet_id


  eks_managed_node_groups = {
      nodes = {
        min_size     = 1
        max_size     = 3
        desired_size = 2

      instance_types = ["t2.small"]
      }
    }
     tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
