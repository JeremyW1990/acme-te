resource "aws_ssm_parameter" "example" {
  name  = local.parameter_name
  type  = "String"
  value = "value"

  tags = {
    owner = "jeremy_wang"
  }
}