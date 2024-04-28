resource "random_id" "postfix" {
  byte_length = 2 # This will generate a random 3-character base62 ID
}

resource "aws_ssm_parameter" "parameter_from_CloudAI" {
  name  = "parameter_from_CloudAI_${random_id.postfix.id}"
  type  = "String"
  value = "your_value_here" # Replace this with the actual value you want to store

  tags = {
    owner = "jeremy_wang"
  }
}