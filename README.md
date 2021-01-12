# Provisioning VPC, ECS and ALB using Terraform

![](https://github.com/devops-art/terraform_ecs)

This is the example of creating a simple infrastructure using Terraform and AWS cloud provider. It consists of:
- Virtual Private Cloud (VPC) with 3 public subnets in 3 availability zones
- Elastic Container Service (ECS)
- Application Load Balancer (ALB)

## How to create the infrastructure?
This example implies that you have already AWS account and Terraform CLI installed.
1. `git clone https://github.com/devops-art/terraform_ecs_workshop.git`
2. cd terraform_ecs_workshop
3. terraform init
4. terraform plan
5. terraform apply

Note: it can take about 5 minutes to provision all resources.
## How to delete the infrastructure?
1. Terminate instances
2. Run `terraform destroy`

## Description

Cluster is created using container instances (EC2 launch type, not Fargate!).

In this example, verified module `vpc` is imported from Terraform Registry, other resources are created in relevant files.

In file `ecs.tf` we create:
  - cluster of container instances _web-cluster_
  - capacity provider, which is basically AWS Autoscaling group for EC2 instances. In this example managed scaling is enabled, Amazon ECS manages the scale-in and scale-out actions of the Auto Scaling group used when creating the capacity provider. I set target capacity to 85%, which will result in the Amazon EC2 instances in your Auto Scaling group being utilized for 85% and any instances not running any tasks will be scaled in.
  - task definition with family _web-family_, volume and container definition is defined in the file container-def.json
  - service _web-service_, desired count is set to 10, which means there are 10 tasks will be running simultaneously on your cluster. There are two service scheduler strategies available: REPLICA and DAEMON, in this example REPLICA is used. Application load balancer is attached to this service, so the traffic can be distributed between those tasks.
  Note: The _binpack_ task placement strategy is used, which places tasks on available instances that have the least available amount of the cpu (specified with the field parameter).

In file `asg.tf` we create:
  - launch configuration
  - key pair
  - security groups for EC2 instances
  - auto-scaling group.

Note: in order to enable ECS managed scaling you need to enable `protect from scale in` from auto-scaling group.

In file `iam.tf` we create roles, which will help us to associate EC2 instances to clusters, and other tasks.

In file `alb.tf` we create Application Load Balancer with target groups, security group and listener.

-----------------------------------------------------------------------------------------------------------------------------------------

git clone https://github.com/devops-art/terraform_ecs_workshop.git
cd terraform_ecs_workshop
terraform init

The S3 bucket is hardcoded to g/devops-art personal one and used for the demonstration.

You need to create your own S3 bucket and then change the main.tf bucket value to your own name:
aws s3api create-bucket --bucket=<enter your bucket name here> --region=<enter your region here>
