terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "~> 0.45"
    }
  }
}

provider "aws" {
  # Configuration options
  region = local.region
}

provider "awscc" {
  # Configuration options
  region = local.region
}
