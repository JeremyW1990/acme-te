provider "aws" {
  region = "us-east-1" 
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ACME-TE"

    workspaces {
      namname = "acme-web-dev-typo"
    }
  }
}
