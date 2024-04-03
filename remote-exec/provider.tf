terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "aws-devops-remote-state"
    key    = "provisioners-remote-exec"
    region = "us-east-1"
    dynamodb_table = "aws-devops-remote-state-locking"
  }
}

provider "aws" {
  region = "us-east-1"
  # Configuration options
}
