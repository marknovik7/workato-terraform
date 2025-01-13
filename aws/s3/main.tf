resource "random_string" "random" {
  keepers = {
    bucket_name = var.bucket_name
  }
  length  = 6
  special = false
  upper   = false
  numeric = false
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.bucket_name}-${random_string.random.result}"
  force_destroy = true

  tags = {
    Name  = "${var.bucket_name}-${random_string.random.result}"
    Owner = var.owner
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

resource "aws_iam_user" "user" {
  name          = "${var.jira_ticket_id}"
  path          = "/s3/"
  force_destroy = true
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

# Intentional error to break destroy operation
resource "time_static" "break_destroy" {
  depends_on = [aws_s3_bucket.bucket]

  triggers = {
    # This condition will always fail during destroy as the S3 bucket will be deleted first.
    always_fail = aws_s3_bucket.bucket.id == null ? "true" : "false"
  }
}

resource "aws_iam_policy" "bucket_policy" {
  name        = "${var.bucket_name}-${random_string.random.result}_policy"
  path        = "/"
  description = "Allow access to S3 bucket"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets"
        ],
        "Resource": "arn:aws:s3:::*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}",
          "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}/*"
        ]
      }
    ]
  })
}
