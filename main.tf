terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.36.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.5.0.0/16"

  tags = {
    Name = "Tee-VPC"
  }
}

locals {
  service_name = "Ochuko"
}

resource "aws_instance" "my_server" {
  ami           = "ami-03cceb19496c25679"
  instance_type = "t2.micro"
  tags = {
    Name = "my_server.${local.service_name}"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-tf-test-bucket11230499360"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_iam_role" "s3-bucket-role" {
  name = "S3BucketRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::891376975226:role/NewRoleForEC2"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "1"

    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject*",
    ]

    resources = [
      "arn:aws:s3:::comdhdoejd123",
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = [aws_iam_role.s3-bucket-role.name]
  policy_arn = aws_iam_policy.policy.arn
}