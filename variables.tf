# --- Global Variables ---
variable "apigateway_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "environment" {
  description = "The environment"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

# --- API Definition ---
variable "body_definition" {
  description = "Definicion del body para HTTP API"
  type        = string
}

variable "certificate_commond_name" {
  description = "Certificate Name"
  type        = string
  default     = ""
}

variable "api_domain_name" {
  description = "Commond Name para el HTTP API"
}

# CloudWatch Logs Variables
variable "log_group_retention" {
  description = "The retention period (in days) for the CloudWatch log group"
  type        = number
}
