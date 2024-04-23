resource "aws_secretsmanager_secret" "secret_manager_from_AI" {
  name       = "secret_manager_from_AI"
  kms_key_id = "alias/aws/secretsmanager" # Optional: specify a KMS key ID if you want to use a customer-managed key

  tags = {
    owner = "jeremy"
  }
}