resource "time_static" "date" {
}

resource "aws_iam_policy" "kms_policy" {
  name        = "${terraform.workspace}_policy"
  path        = "/"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
		{
			"Effect": "Allow",
			"Action": [
				"kms:ListKeys",
				"kms:Decrypt",
				"kms:Encrypt",
				"kms:ListAliases",
				"kms:ReEncryptTo",
				"kms:DescribeKey",
				"kms:Verify",
				"kms:CreateKey",
				"kms:Sign",
				"kms:ReEncryptFrom"
			],
			"Resource": "*"
		}
   ]
  })
}

resource "aws_iam_role" "kms_role" {
  name = "${terraform.workspace}_role" //format("%s-%s", var.kms_name, "role")

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

resource "aws_iam_role_policy_attachment" "role_kms_policy_attachment" {
  role       = aws_iam_role.kms_role.name
  policy_arn = aws_iam_policy.kms_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloud_watch_policy" {
  role       = aws_iam_role.kms_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}
