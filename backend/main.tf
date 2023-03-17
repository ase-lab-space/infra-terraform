resource "aws_s3_bucket" "tfstate" {
  bucket = "ase-lab-tfstate"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "tfstate_lock" {
  name           = "ase-lab-tfstate"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
