module "tfstate" {
  source = "./backend"
}

module "mail_assets" {
  source  = "./mail_assets"
  acm_arn = aws_acm_certificate.ase_lab_space.arn
}

module "website" {
  source = "./website"
}
