terraform {
  backend "s3" {
    bucket = "sctp-ce7-tfstate"               # Terraform State bucket name
    key    = "ce7-grp-2-wtc-capstone.tfstate" # Name of your tfstate file
    region = "us-east-1"                      # Terraform State bucket region
  }
  required_version = "~> 1.9.5"
}
