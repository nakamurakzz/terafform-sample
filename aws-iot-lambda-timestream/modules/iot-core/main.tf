resource "aws_iot_topic_rule" "iot_topic_rule" {
  name        = "iot_topic_rule"
  enabled     = true
  sql         = "SELECT * FROM '${var.iot_topic_rule_name-suffix}'"
  sql_version = "2016-03-23"

  lambda {
    function_arn = var.lambda_function_arn
  }
}

resource "aws_lambda_permission" "iot_topic_rule_permission" {
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "iot.amazonaws.com"
  source_arn    = aws_iot_topic_rule.iot_topic_rule.arn
}
