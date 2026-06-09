provider "aws" {
  region = "us-east-1" # Replace with your target region
}

# 1. Create the S3 Bucket for Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket        = "zen-pharma-terraform-state-hemanth-raj-gandham"
  force_destroy = false # Prevents accidental deletion of your state
}

# 2. Enable Versioning (Crucial for state files)
resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 3. Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

