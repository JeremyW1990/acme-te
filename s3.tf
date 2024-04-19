

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-12345"  # Bucket names must be unique across all AWS users

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Development"
  }
}
