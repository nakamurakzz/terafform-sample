########################################
# Lambda の作成
########################################
data "archive_file" "zip" {
  type        = "zip"
  source_file = "./modules/lambda/bin/main"
  output_path = "./modules/lambda/archive/main.zip"
}

# Lambda実行用のポリシー
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

# Lambda実行用のポリシー
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}


resource "aws_lambda_function" "lambda" {
  function_name    = "hello-lambda"
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256

  role    = aws_iam_role.iam_for_lambda.arn
  handler = "main"
  runtime = "go1.x"

  memory_size = 256
  timeout     = 30

  environment {
    variables = {
      temp = "hello"
    }
  }
}
