output "request_bucket" {
  value = aws_s3_bucket.request_bucket.id
}

output "response_bucket" {
  value = aws_s3_bucket.response_bucket.id
}

output "translate_role_arn" {
  value = aws_iam_role.translate_role.arn
}
