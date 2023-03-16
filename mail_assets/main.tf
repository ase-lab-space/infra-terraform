module "cloudfront" {
  source    = "./cloudfront"
  s3_bucket = module.s3.s3_bucket
  acm_arn   = var.acm_arn
}

module "s3" {
  source                                    = "./s3"
  cloudfront_origin_access_identity_iam_arn = module.cloudfront.cloudfront_origin_access_identity_iam_arn
}
