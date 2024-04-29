provider "random" {}

resource "random_string" "postfix" {
  length  = 3
  special = false
  upper   = false
  number  = true
}