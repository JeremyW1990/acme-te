provider "random" {}

resource "random_pet" "name_postfix" {
  length    = 1
  separator = "_"
}

locals {
  parameter_name = "parameter_from_CloudAI_${random_pet.name_postfix.id}"
}

resource "aws_ssm_parameter" "cloudai_parameter" {
  name  = local.parameter_name
  type  = "String"
  value = "value"

  tags = {
    owner = "jeremy_wang"
  }
}

output "ssm_parameter_name" {
  value = aws_ssm_parameter.cloudai_parameter.name
}