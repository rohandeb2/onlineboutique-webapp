provider "aws" {
  region = "us-west-2"
}

locals {
  services = [
    "emailservice",
    "checkoutservice",
    "recommendationservice",
    "frontend",
    "paymentservice",
    "productcatalogservice",
    "cartservice",
    "loadgenerator",
    "currencyservice",
    "shippingservice",
    "adservice"
  ]
}

resource "aws_ecr_repository" "services" {
  for_each = toset(local.services)

  name = each.value

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = true

  tags = {
    Environment = "production"
    Service = each.value
  }
}