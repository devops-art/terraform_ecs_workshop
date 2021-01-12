provider "aws" {
  access_key = "#########################"
  secret_key = "#########################"
  region     = var.region
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  country  = "USA"
  city     = "New York"
  az_list  = join(",", data.aws_availability_zones.available.names)
  region   = data.aws_region.current.description
  location = "In ${local.region} there are AZ: ${local.az_list}"
}

#terraform {
#  backend "s3" {
#    bucket = "art-devops-project"
#    key    = "state/terraform.tfstate"
#    region = var.region
#  }
