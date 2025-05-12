# This is a boot strap, it creates the S3 bucket and the DynamoDB for state locking.
# Use this first before creating the infra
# How to use: terraform init then terraform apply. Then move to the dev environment. And do the same. 

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.s3_bucket_name

  tags = merge(
    local.default_tags, {
      Name = "terraform_state"
    }
  )
}

/*
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
      status = "Enabled"  # Disabled as default, enable it for production
    }
}
*/

resource "aws_s3_bucket_server_side_encryption_configuration" "SSE_terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

/*
resource "aws_s3_bucket_lifecycle_configuration" "example" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    id = "rule-1"

    # ... other transition/expiration actions ...

    status = "Enabled"  # Set to disabled , can toggle ON (highly recommended) 
  }
}
*/

