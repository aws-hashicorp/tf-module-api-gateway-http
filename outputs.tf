# -------------------------
# outputs HTTP API
# -------------------------
output "http_api_execution_arn" {
  description = "Execution ARN of the HTTP API Gateway."
  value       = aws_apigatewayv2_api.http_api.execution_arn
}

output "http_api_id" {
  description = "ID of the HTTP API Gateway."
  value       = aws_apigatewayv2_api.http_api.id
}

# -------------------------
# outputs API Authorizer
# -------------------------
output "authorizer_id" {
  description = "ID of the API Gateway HTTP authorizer."
  value       = aws_apigatewayv2_authorizer.api_authorizer[0].id
}
