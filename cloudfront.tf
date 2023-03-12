resource "aws_cloudfront_distribution" "ase-lab-mail" {
  origin {
    domain_name = aws_s3_bucket.main.bucket_domain_name
    origin_id   = aws_s3_bucket.main.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.ase-lab-mail-identity.cloudfront_access_identity_path
    }
  }

  enabled = true

  aliases = ["mail.ase-lab.space"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.main.id

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0

    cache_policy_id = aws_cloudfront_cache_policy.mail-cf-cache-policy.id
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.ase_lab_space.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_cache_policy" "mail-cf-cache-policy" {
  name        = "mail-cache-policy"
  min_ttl     = 0
  default_ttl = 3600
  max_ttl     = 86400
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "ase-lab-mail-identity" {}
