module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "2.64.0"
  name           = "test_ecs_provisioning"
  cidr           = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"] // local.az_list
  public_subnets = var.public_subnet_cidrs
  tags           = var.common_tags
}

data "aws_vpc" "main" {
  id = module.vpc.vpc_id
}
