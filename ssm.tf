resource "aws_ssm_parameter" "example_parameter" {
  name  = "/config/service/example-parameter"
  type  = "String"
  value = "ExampleValue"
  tags = {
    Environment = "development"
  }
}

