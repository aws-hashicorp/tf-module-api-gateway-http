# AWS API Gateway HTTP API Terraform Module

This module provisions an AWS API Gateway HTTP API with optional custom domain, CloudWatch logging, and Lambda authorizer integration. All resources are fully tagged and configured for environment-based deployment.

## Features

- **API Gateway HTTP API (v2)**
- **Custom Domain Name Support** (with ACM certificate)
- **CloudWatch Log Group** for access logging
- **Stage with Access Logging**
- **Optional Lambda Authorizer**
- **Environment and Tag-Driven Configuration**

## Usage

```hcl
module "api_gateway" {
  source = "./path/to/this/module"

  apigateway_name            = "my-api"
  environment                = "prod"
  api_body_definition        = file("openapi.yaml")
  certificate_common_name    = "api.example.com"
  api_domain_name            = "api.example.com"
  log_group_retention        = 7

  # Authorizer (optional)
  authorizer_type            = "REQUEST"
  aws_region                 = "us-east-1"
  authorizer_lambda_arn      = "arn:aws:lambda:us-east-1:123456789012:function:my-authorizer"
  identity_sources           = ["$request.header.Authorization"]
  authorizer_name            = "my-authorizer"
  authorizer_payload_version = "2.0"

  tags = {
    Project     = "my-project"
    Environment = "prod"
  }
}
```

## Input Variables

| Name                        | Description                                                         | Type           | Default      | Required |
|-----------------------------|---------------------------------------------------------------------|----------------|--------------|:--------:|
| apigateway_name             | The name of the API Gateway                                         | string         | n/a          | yes      |
| environment                 | The environment (e.g., dev, staging, prod)                          | string         | "dev"        | no       |
| tags                        | A map of tags to assign to resources                                | map(string)    | {}           | no       |
| api_body_definition         | Body definition for the HTTP API                                    | string         | n/a          | yes      |
| certificate_common_name     | Certificate common name for custom domain                           | string         | ""           | no       |
| api_domain_name             | Domain name for the HTTP API                                        | string         | ""           | no       |
| log_group_retention         | The retention period (in days) for the CloudWatch log group         | number         | 1            | no       |
| authorizer_type             | The type of authorizer (e.g., REQUEST, JWT)                         | string         | n/a          | yes*     |
| aws_region                  | AWS region where the authorizer will be deployed                    | string         | n/a          | yes*     |
| authorizer_lambda_arn       | ARN of the Lambda function used as authorizer                       | string         | n/a          | yes*     |
| identity_sources            | List of identity sources for authorizer                             | list(string)   | n/a          | yes*     |
| authorizer_name             | Name of the authorizer                                              | string         | n/a          | yes*     |
| authorizer_payload_version  | Payload version for the authorizer                                  | string         | n/a          | yes*     |

**\*** Authorizer variables are only required if using a Lambda authorizer.

## Outputs

- (Add outputs here as needed, e.g., API endpoint, domain name, stage name, etc.)

## Requirements

- Terraform 1.0+
- AWS Provider 4.0+

## Notes

- If you wish to use a custom domain, ensure your ACM certificate is issued in the same region as your API Gateway.
- Authorizer variables are optional unless you require authentication for your API.

## License

MIT