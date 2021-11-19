terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.65"
      configuration_aliases = [ aws.us_east_1 ]
    }
  }
}
