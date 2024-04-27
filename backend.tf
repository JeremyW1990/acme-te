terraform {
  backend "s3" {
    bucket = "cloud-ai-demo-infra"
    key    = "cloud-ai/terraform.tfstate"
    region = "us-east-1"
    # Optionally add encryption
    encrypt = false
    # Optionally enable DynamoDB for state locking
    # dynamodb_table = "my-lock-table"
  }
}