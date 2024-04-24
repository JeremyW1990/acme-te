resource "aws_secretsmanager_secret" "secret_manager_from_CloudAI" {
  name = "secret_manager_from_CloudAI"

  tags = {
    owner = "jeremy"
  }
}}
