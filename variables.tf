# -------------------------
# Global Variables
# -------------------------

variable "apigateway_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

# -------------------------
# API Definition Variables
# -------------------------

variable "api_body_definition" {
  description = "Body definition for the HTTP API"
  type        = string
}

variable "certificate_common_name" {
  description = "Certificate common name"
  type        = string
  default     = ""
}

variable "api_domain_name" {
  description = "Domain name for the HTTP API"
  type        = string
  default     = ""
}

# -------------------------
# CloudWatch Logs Variables
# -------------------------

variable "log_group_retention" {
  description = "The retention period (in days) for the CloudWatch log group"
  type        = number
  default     = 1
}

# -------------------------
# Authorizer Variables
# -------------------------

variable "create_authorizer" {
  description = "Flag to create the authorizer"
  type        = bool
  default     = true
}

variable "authorizer_type" {
  description = "The type of authorizer for API Gateway (e.g., REQUEST or JWT)"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the authorizer will be deployed"
  type        = string
}

variable "authorizer_lambda_arn" {
  description = "ARN of the Lambda function used as the authorizer"
  type        = string
}

variable "identity_sources" {
  description = "List of identity sources for the authorizer"
  type        = list(string)
}

variable "authorizer_name" {
  description = "Name of the authorizer"
  type        = string
}

variable "authorizer_payload_version" {
  description = "Payload version for the authorizer"
  type        = string
}
