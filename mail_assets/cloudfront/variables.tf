variable "s3_bucket" {
  type = object({
    id                 = string
    bucket_domain_name = string
  })
}

variable "acm_arn" {
  type = string
}
