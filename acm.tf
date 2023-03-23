resource "aws_acm_certificate" "ase_lab_space" {
  provider          = aws.us-east-1
  domain_name       = "ase-lab.space"
  validation_method = "DNS"
  subject_alternative_names = [
    "ase-lab.space",
    "*.ase-lab.space",
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "ase_lab_space" {
  provider = aws.us-east-1
  certificate_arn         = aws_acm_certificate.ase_lab_space.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_us_verification : record.fqdn]
}
