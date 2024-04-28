resource "random_pet" "postfix" {
  length    = 1
  separator = "-"
  // Ensuring the output is always 3 character long
  keepers = {
    uuid = "${uuid()}"
  }
}

resource "aws_ssm_parameter" "parameter_from_CloudAI" {
  // Concatenating the base name with the postfix name
  name  = "parameter_from_CloudAI_${random_pet.postfix.id}"
  type  = "String" // Assuming we want to store a simple string. This can be changed to StringList or SecureString if required.
  value = "your_value_here" // Replace 'your_value_here' with the actual value you want to store.

  tags = {
    owner = "jeremy_wang"
  }
}}