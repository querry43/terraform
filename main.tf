terraform {
  required_version = ">= 0.12.0"
  backend s3 {
    bucket = "underdogma-tf-state"
    key    = "tfstate"
    region = "us-west-2"
  }
}

provider aws {
  region = "us-west-2"
}

module tf_state {
  source     = "./modules/s3_bucket"
  name       = "underdogma-tf-state"
  versioning = true
}
