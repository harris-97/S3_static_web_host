resource "aws_s3_bucket" "website" {
  bucket        = "var.bucket_name"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.website.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.website.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "null_resource" "upload_files" {
  provisioner "local-exec" {
    command = "aws s3 cp C:\\Harris\\Project s3://${aws_s3_bucket.website.id}/ --recursive --acl public-read"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.website.id
}

output "website_url" {
  value = aws_s3_bucket_website_configuration.website_config.website_endpoint
}
