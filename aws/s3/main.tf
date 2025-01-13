resource "random_string" "random" {
  keepers = {
    bucket_name = var.bucket_name
  }
  length  = 6
  special = false
  upper = false
  numeric = false
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}-${random_string.random.result}"
  force_destroy = true

  tags = {
    Name        = "${var.bucket_name}-${random_string.random.result}"
    Owner       = var.owner
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

resource "time_static" "date" {
}

resource "aws_iam_policy" "bucket_policy" {
  name        = "${var.bucket_name}-${random_string.random.result}_policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
           "s3:GetBucketLocation",
            "s3:ListAllMyBuckets"
        ],
        "Resource": "arn:aws:s3:::*"
      },      
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}",
          "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}/*",
        ]
      }
   ]
  })
}

resource "aws_iam_role" "bucket_role" {
  name = "${var.bucket_name}-${random_string.random.result}_role" //format("%s-%s", var.bucket_name, "role")

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
            "AWS" = var.aws_account_id
        },
        Condition = {
            StringEquals = {
                "sts:ExternalId" = "workato_iam_external_id_${var.workato_iam_external_id}"
            }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role_bucket_policy_attachment" {
  role       = aws_iam_role.bucket_role.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloud_watch_policy" {
  role       = aws_iam_role.bucket_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_user" "user" {
  name          = "${var.jira_ticket_id}"
  path          = "/s3/"
  force_destroy = true
}

# resource "aws_iam_user_login_profile" "user" {
#   user    = "${aws_iam_user.user.name}"
#   pgp_key = "keybase:${var.pgp_key}"
#   password_reset_required = false
# }

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}

data "aws_kms_alias" "shared_kms_key" {
  name = "alias/shared-kms-key"
}