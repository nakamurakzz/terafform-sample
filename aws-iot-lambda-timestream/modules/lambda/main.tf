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

# Lambda実行用のロール
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

# CloudWatch Logs用のポリシー
data "aws_iam_policy_document" "function_logging_policy" {
  version = "2012-10-17"
  statement {
    sid    = ""
    effect = "Allow"

    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
  }
}

resource "aws_iam_policy" "function_logging_policy" {
  name        = "function_logging_policy"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = data.aws_iam_policy_document.function_logging_policy.json
}

# ロールにLoggingのポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.id
  policy_arn = aws_iam_policy.function_logging_policy.arn
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


########################################
# CloudWatchLog Group の作成
########################################
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 7
}
