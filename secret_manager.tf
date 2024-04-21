resource "aws_secretsmanager_secret" "secret_manager_from_AI" {
  name     = "secret_manager_from_AI"

  tags = {
    owner = "jeremy"
  }
}