provider "aws" {
  region = "us-east-1"
}

resource "random_id" "name_postfix" {
  byte_length = 2 # generates a 4 character string in hex format
  keepers = {
    always_change = "${timestamp()}"
  }
}

resource "aws_ssm_parameter" "parameter_from_CloudAI" {
  name  = "parameter_from_CloudAI_${random_id.name_postfix.hex}"
  type  = "String"
  value = "SomeValue" # Replace with the actual value you want to store

  tags = {
    owner = "jeremy_wang"
  }

  lifecycle {
    create_before_destroy = true
  }
}