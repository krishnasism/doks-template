terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "terraformlocksbucket"
    key    = "locks/digitalocean"
    region = "us-east-1"
  }
}

provider "digitalocean" {
  // Token provided by env var (use make)
}

