########################################
# VPC の作成
########################################
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "web-service-prod-vpc"
    Project = "web-service"
    Env     = "prod"
  }
}

########################################
# サブネット の作成
########################################
resource "aws_subnet" "web-service-prod-alb-a-subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.100.0/24"

  tags = {
    Name    = "web-service-alb-a-subnet"
    Project = "web-service"
    Env     = "prod"
  }
}

resource "aws_subnet" "web-service-prod-alb-c-subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.101.0/24"

  tags = {
    Name    = "web-service-alb-c-subnet"
    Project = "web-service"
    Env     = "prod"
  }
}

resource "aws_subnet" "web-service-prod-ec2-a-subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.102.0/24"

  tags = {
    Name    = "web-service-ec2-a-subnet"
    Project = "web-service"
    Env     = "prod"
  }
}

########################################
# IG の作成
########################################
resource "aws_internet_gateway" "web-service-prod-internetgateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "web-service-prod-internetgateway"
    Project = "web-service"
    Env     = "prod"
  }
}
