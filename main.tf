resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name" # Ensure this bucket name is unique globally.
  acl    = "private" # This sets the bucket to be private.

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Dev"
  }
}