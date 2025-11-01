terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.25.0"
    }
  }

  backend "s3" {
    bucket = "rohan-microservices-1"
    key    = "ec2/terraform.tfstate"
    region = "us-west-2"
  }

  required_version = ">= 1.6.3"
}
provider "aws" {
  region = "us-west-2"
}
