provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "rohan-microservices-1"

  tags = {
    Name        = "rohan"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket1_versioning" {
  bucket = aws_s3_bucket.bucket1.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "bucket2" {
  bucket = "rohan-microservices-2"

  tags = {
    Name        = "rohan"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "bucket2_versioning" {
  bucket = aws_s3_bucket.bucket2.id
  versioning_configuration {
    status = "Enabled"
  }
}
