resource "aws_dynamodb_table" "ravenc-tf-state-lock" {
  name             = "${var.stack_name}-tf-state-lock"
  hash_key         = "LockID"
  billing_mode     = "PROVISIONED"
  read_capacity    = 20
  write_capacity   = 20
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  attribute {
    name = "LockID"
    type = "S"
  }
}