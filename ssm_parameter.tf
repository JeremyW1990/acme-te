resource "aws_ssm_parameter" "parameter_from_CloudAI" {
  name        = "parameter_from_CloudAI_${random_string.postfix.result}"
  description = "Parameter managed by CloudAI with a unique postfix"
  type        = "String"
  value       = "MyParameterValue" # Add the desired parameter value here.

  tags = {
    "owner" = "jeremy_wang"
  }
}