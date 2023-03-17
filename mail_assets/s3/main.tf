resource "aws_s3_bucket" "main" {
  bucket_prefix = "ase-lab-mail"

  tags = {
    Name = "ASE-Lab. Mail Assets"
  }
}

resource "aws_s3_bucket_acl" "main_acl" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "main_bucket_policy" {
  bucket = aws_s3_bucket.main.id
  policy = data.aws_iam_policy_document.ase-lab-mail-s3-policy.json
}

data "aws_iam_policy_document" "ase-lab-mail-s3-policy" {
  statement {
    sid    = "Allow CloudFront Access"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [var.cloudfront_origin_access_identity_iam_arn]
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.main.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
