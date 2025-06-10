# -------------------------
# CloudWatch Logs
# -------------------------
resource "aws_cloudwatch_log_group" "api_log_group" {
  name              = "/api/${var.apigateway_name}"
  retention_in_days = var.log_group_retention
  tags              = var.tags
}

# -------------------------
# Create HTTP API
# -------------------------
resource "aws_apigatewayv2_api" "http_api" {
  name          = var.apigateway_name
  protocol_type = "HTTP"
  description   = "HTTP API Gateway v2 ${var.apigateway_name}"
  body          = var.api_body_definition
  tags          = var.tags
}

# -------------------------
# API Domain Name
# -------------------------
resource "aws_apigatewayv2_domain_name" "api_domain" {
  domain_name = var.api_domain_name

  domain_name_configuration {
    certificate_arn = data.aws_acm_certificate.api_acm_cert.arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }
}

# -------------------------
# API Stage
# -------------------------
resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = var.environment
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_log_group.arn
    format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"
  }

  tags = var.tags
}

# -------------------------
# API Mapping Association
# -------------------------
resource "aws_apigatewayv2_api_mapping" "api_mapping" {
  api_id      = aws_apigatewayv2_api.http_api.id
  domain_name = aws_apigatewayv2_domain_name.api_domain.domain_name
  stage       = aws_apigatewayv2_stage.api_stage.id
}

# -------------------------
# API Authorizer
# -------------------------
resource "aws_apigatewayv2_authorizer" "api_authorizer" {
  count                             = var.create_authorizer ? 1 : 0
  api_id                            = aws_apigatewayv2_api.http_api.id
  authorizer_type                   = var.authorizer_type
  authorizer_uri                    = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.authorizer_lambda_arn}/invocations"
  identity_sources                  = var.identity_sources
  name                              = var.authorizer_name
  authorizer_payload_format_version = var.authorizer_payload_version
}
