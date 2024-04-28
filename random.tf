resource "random_pet" "postfix" {
  length    = 1
  separator = "_"
}

resource "random_string" "random" {
  length  = 3
  special = false
  upper   = false
}

locals {
  parameter_name = "parameter_from_CloudAI_${random_string.random.result}"
}