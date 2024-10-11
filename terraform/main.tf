provider "aws" {
  region = var.region
}

# Create the S3 bucket
resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.static_site.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# Configure website hosting for the S3 bucket
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_site.id

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }
}

# Define the policy for the S3 bucket to allow public read access
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.static_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_site.arn}/*"
      }
    ]
  })
}

# Upload the index.html file
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "./index.html"
  content_type = "text/html"
}

# Upload the error.html file
resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "error.html"
  source = "./error.html"
  content_type = "text/html"
}
