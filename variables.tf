variable "region" {
  description = "Please Enter AWS Region to deploy Server"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  type        = string
  description = "The name for ssh key, used for aws_launch_configuration"
}

variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
}

variable "common_tags" {
  description = "Common Tags to apply to all resources"
  type        = map
  default = {
    Owner       = "Arthur S"
    Project     = "Test"
    CostCenter  = "11111"
    Environment = "dev"
  }

  variable "public_subnet_cidrs" {
    default = [
      "10.0.1.0/24",
      "10.0.2.0/24",
      "10.0.3.0/24"
    ]
  }

  variable "private_subnet_cidrs" {
    default = [
      "10.0.11.0/24",
      "10.0.22.0/24",
      "10.0.33.0/24"
    ]
  }
