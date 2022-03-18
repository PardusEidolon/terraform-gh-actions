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

provider "aws" {
  region = local.region
}

locals {
  #   availability_zone = "${local.region}a"
  #   name              = "ec2-volume-attachment"
  region = "ap-southeast-2"
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

################################################################################
# Ec2 Instance
################################################################################

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "instance-primary"

  ami                         = "ami-0b7dcd6e6fd797935"
  instance_type               = "t2.micro"
  key_name                    = "parduseidolon_ed25519"
  monitoring                  = true
  vpc_security_group_ids      = ["sg-0c9187e9829310c01"]
  subnet_id                   = "subnet-05a0c544365d4ad9d"
  associate_public_ip_address = true

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 30
      #   tags = {
      #     Name = "my-root-block"
      #   }
    }
  ]

  tags = local.tags
}