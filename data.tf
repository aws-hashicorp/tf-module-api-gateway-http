data "aws_acm_certificate" "acm_api" {
  domain   = var.certificate_commond_name
  statuses = ["ISSUED"]
}
