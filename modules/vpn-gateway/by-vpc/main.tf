terraform {
  required_version = ">= 0.12.31, < 2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.32"
    }
  }
}



