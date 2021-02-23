
terraform {
  backend "s3" {
    bucket = "terraformlive"
    region = var.region
  }
}