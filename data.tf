data "aws_acm_certificate" "api_acm_cert" {
  domain   = var.certificate_common_name
  statuses = ["ISSUED"]
}