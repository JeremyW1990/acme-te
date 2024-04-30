

resource "random_pet" "name_postfix" {
  length    = 1
  separator = "_"
}

resource "aws_ssm_parameter" "parameter_from_CloudAI" {
  name  = "parameter_from_CloudAI_${random_pet.name_postfix.id}"
  type  = "String"
  value = "some_value"

  tags = {
    owner = "jeremy_wang"
  }
}