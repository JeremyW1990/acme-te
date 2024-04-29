resource "random_string" "postfix" {
  length  = 3
  upper   = false
  special = false
  numeric = true
  lower   = true
}

resource "aws_ssm_parameter" "parameter_from_CloudAI" {
  name        = "parameter_from_CloudAI_${random_string.postfix.result}"
  type        = "String"
  value       = "some_value" # Placeholder for the actual value you want to store.
  description = "This parameter is managed by Terraform"

  tags = {
    "owner" = "jeremy_wang"
  }
}