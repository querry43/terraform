terraform {
  backend s3 {
    bucket = "underdogma-tf-state"
    key    = "tfstate"
    region = "us-west-2"
  }
}

provider aws {
  profile = "home"
  region  = "us-west-2"
}

provider aws {
  alias   = "us_east_1"
  profile = "home"
  region  = "us-east-1"
}

module tf_state {
  source     = "./modules/aws_s3_bucket"
  name       = "underdogma-tf-state"
  versioning = true
}
