terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  cloud {
    organization = "jack-sandbox"

    workspaces {
      name = "github-actions"
    }
  }
}
