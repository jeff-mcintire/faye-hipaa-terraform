# provider "aws" {
#   region = "us-east-1"
# }

#-------------------------------------------
#               fayehipaahosting.com
#-------------------------------------------
# SSL Certificate
resource "aws_acm_certificate" "hipaa_ssl_certificate" {
  domain_name       = "*.${var.hipaa_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "hipaa_cert_validation" {
  provider = aws.networking
  for_each = {
    for dvo in aws_acm_certificate.hipaa_ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.hipaa_zone.zone_id
}

# Uncomment the validation_record_fqdns line if you do DNS validation instead of Email.
resource "aws_acm_certificate_validation" "hipaa_cert_validation" {
  certificate_arn         = aws_acm_certificate.hipaa_ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.hipaa_cert_validation : record.fqdn]
}