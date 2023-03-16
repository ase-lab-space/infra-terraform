output "cloudfront_origin_access_identity_iam_arn" {
  value = aws_cloudfront_origin_access_identity.ase-lab-mail-identity.iam_arn
}

output "cloudfront_dist_domain_name" {
  value = aws_cloudfront_distribution.ase-lab-mail.domain_name
}

output "cloudfront_dist_zone_id" {
  value = aws_cloudfront_distribution.ase-lab-mail.hosted_zone_id
}
