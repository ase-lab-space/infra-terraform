resource "aws_route53_zone" "ase-lab_space" {
  name = "ase-lab.space"
}

resource "aws_route53_record" "main_content_cloudfront" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "ase-lab.space"
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = "d1l2nysyveir50.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
  }
}

resource "aws_route53_record" "mx" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "ase-lab.space"
  type    = "MX"
  ttl     = 3600
  records = [
    "5 gmr-smtp-in.l.google.com.",
    "10 alt1.gmr-smtp-in.l.google.com.",
    "20 alt2.gmr-smtp-in.l.google.com.",
    "30 alt3.gmr-smtp-in.l.google.com.",
    "40 alt4.gmr-smtp-in.l.google.com.",
  ]
}

resource "aws_route53_record" "ns" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "ase-lab.space"
  type    = "NS"
  ttl     = 172800
  records = [
    "ns-336.awsdns-42.com.",
    "ns-1336.awsdns-39.org.",
    "ns-647.awsdns-16.net.",
    "ns-1764.awsdns-28.co.uk.",
  ]
}

resource "aws_route53_record" "soa" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "ase-lab.space"
  type    = "SOA"
  ttl     = 900
  records = [
    "ns-336.awsdns-42.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",
  ]
}

resource "aws_route53_record" "google-verification" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "ase-lab.space"
  type    = "TXT"
  ttl     = 300
  records = [
    "google-site-verification=Z9hgPPjwYDaRglgqa4QrV-_vYesX-RQpXuxI267P2sU",
  ]
}

resource "aws_route53_record" "acm_cname" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "_1949708a13798eb464c7b03b8f666c2e.ase-lab.space"
  type    = "CNAME"
  ttl     = 60
  records = [
    "_0afc96ece3966f27b4b6da3d2fa7fb32.xdvyhgsvzs.acm-validations.aws.",
  ]
}

resource "aws_route53_record" "github_verification" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "_github-challenge-ase-lab-space-organization.ase-lab.space"
  type    = "TXT"
  ttl     = 300
  records = [
    "b79dbb89e9",
  ]
}

resource "aws_route53_record" "acm_us_verification" {
  for_each = {
    for dvo in aws_acm_certificate.ase_lab_space.domain_validation_options : dvo.domain_name => {
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
  zone_id         = aws_route53_zone.ase-lab_space.id
}

resource "aws_route53_record" "ase_lab_mail_a" {
  zone_id = aws_route53_zone.ase-lab_space.id
  name    = "mail.ase-lab.space"
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = module.mail_assets.cloudfront_dist_domain_name
    zone_id                = module.mail_assets.cloudfront_dist_zone_id
  }
}
