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
      identifiers = [aws_cloudfront_origin_access_identity.ase-lab-mail-identity.iam_arn]
    }
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.main.arn}/*"
    ]
  }
}
