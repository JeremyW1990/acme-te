resource "aws_ssm_parameter" "parameter_from_CloudAI" {
  name  = "parameter_from_CloudAI"
  type  = "String" # Assuming we want to store a simple string. This can be changed to "StringList" or "SecureString" based on requirement.
  value = "your_value_here" # Please replace 'your_value_here' with the actual value you want to store.

  tags = {
    owner = "jeremy_wang"
  }
}