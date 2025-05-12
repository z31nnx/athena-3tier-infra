# Backend remote state 
terraform {
  backend "s3" {
    bucket       = "athena-tfstate-bucket-v7"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # new state locking, no need for DynamoDB
  }
}
