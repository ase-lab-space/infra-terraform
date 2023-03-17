terraform {
  backend "s3" {
    bucket         = "ase-lab-tfstate"
    key            = "terraform.tfstate"
    encrypt        = true
    region         = "ap-northeast-1"
    dynamodb_table = "ase-lab-tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58.0"
    }
  }
  required_version = "~> 1.4.2"
}

