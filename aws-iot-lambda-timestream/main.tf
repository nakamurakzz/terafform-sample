terraform {
  required_version = ">= 1.4.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region                   = "ap-northeast-1"
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "terraform"

  default_tags {
    tags = {
      Project = "iot-lambda-timestream"
    }
  }
}

module "lambda" {
  source = "./modules/lambda"
}


module "iot_core" {
  source               = "./modules/iot-core"
  lambda_function_arn  = module.lambda.function_arn
  lambda_function_name = module.lambda.function_name
}
