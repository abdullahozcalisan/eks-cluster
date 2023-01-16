# --- root/main.tf ---

provider "aws" {
  region = local.location
}

locals {
  name        = "eks-cluster-deployment"
  location    = "us-east-1"
  environment = "dev"
  vpc_cidr    = "10.123.0.0/16"

  tags = {
    project     = "eks_project"
    environment = "dev"
    managedby   = "terraform"
  }
}

module "networking" {
  source           = "./modules/networking"
  vpc_cidr         = local.vpc_cidr
  tags             = local.tags
  public_sn_count  = 2
  private_sn_count = 2
  availabilityzone = "us-east-1a"
  azs              = 2
}

module "cluster" {
  source          = "./modules/cluster"
  tags            = local.tags
  name            = local.name
  vpc_id          = module.networking.vpc_id
  ec2_ssh_key     = "EKS-Key"
  desired_size    = 2
  min_size        = 1
  max_size        = 5
  public_subnets  = module.networking.public_subnets
  private_subnets = module.networking.private_subnets
}