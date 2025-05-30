# CloudWatch Logs
resource "aws_cloudwatch_log_group" "cloud_watch_logs" {
  name              = "/api/${var.apigateway_name}"
  retention_in_days = var.log_group_retention

  tags = var.tags
}

# Create HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = var.apigateway_name
  protocol_type = "HTTP"
  description   = "HTTP API Gateway v2 ${var.apigateway_name}"
  body          = var.body_definition

  tags = var.tags
}

# Create API Domine 
resource "aws_apigatewayv2_domain_name" "api_domain_name" {
  domain_name = var.api_domain_name

  domain_name_configuration {
    certificate_arn = data.aws_acm_certificate.acm_api.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = var.environment
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.cloud_watch_logs.arn
    format = ("$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"
    )
  }

  tags = var.tags

}

# Create Mapping Association
resource "aws_apigatewayv2_api_mapping" "mapping" {
  api_id      = aws_apigatewayv2_api.http_api.id
  domain_name = var.api_domain_name
  stage       = aws_apigatewayv2_stage.stage.id

}
