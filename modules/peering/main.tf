/**
* Auto-generated technical documentation is created using [`terraform-docs`](https://terraform-docs.io/)
*/
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 6.0"
      configuration_aliases = [aws.requester, aws.accepter]
    }
  }
}
