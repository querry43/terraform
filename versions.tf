terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.47"
      configuration_aliases = [ aws.us_east_1 ]
    }
  }
}
