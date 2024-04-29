resource "random_string" "postfix" {
  length  = 3
  upper   = false
  lower   = true
  number  = false
  special = false
}

resource "aws_ssm_parameter" "parameter_from_cloud_ai" {
  name  = "parameter_from_CloudAI_${random_string.postfix.result}"
  type  = "String"
  value = "your_value_here"

  tags = {
    owner = "jeremy_wang"
  }
}