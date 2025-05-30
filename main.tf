resource "aws_apigatewayv2_api" "http_api" {
  name          = "my-http-api"
  protocol_type = "HTTP"
  description   = "HTTP API Gateway v2"
  body          = var.body_definition
}

/* resource "aws_apigatewayv2_integration" "http_integration" {
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
  integration_uri    = "https://tu-backend.com/endpoint"
  connection_type    = "VPC_LINK"
  connection_id      = var.vpc_link_id
} */