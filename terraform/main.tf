provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "request_bucket" {
  bucket = "${var.project_name}-request-bucket"
  tags = {
    Name = "Cloudlingo Request Bucket"
  }
}

resource "aws_s3_bucket" "response_bucket" {
  bucket = "${var.project_name}-response-bucket"
  tags = {
    Name = "Cloudlingo Response Bucket"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "request_lifecycle" {
  bucket = aws_s3_bucket.request_bucket.id

  rule {
    id     = "ExpireObjects"
    status = "Enabled"

    filter {}

    expiration {
      days = 30
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "response_lifecycle" {
  bucket = aws_s3_bucket.response_bucket.id

  rule {
    id     = "ExpireObjects"
    status = "Enabled"

    filter {}

    expiration {
      days = 30
    }
  }
}

resource "aws_iam_role" "translate_role" {
  name = "${var.project_name}-translate-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "translate_policy" {
  name        = "${var.project_name}-policy"
  description = "Policy for Lambda to access Translate and S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.request_bucket.arn}/*",
          "${aws_s3_bucket.response_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "translate:TranslateText"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "translate_role_attach" {
  role       = aws_iam_role.translate_role.name
  policy_arn = aws_iam_policy.translate_policy.arn
}
