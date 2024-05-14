data "aws_bedrock_foundation_models" "test"{

}

resource "time_static" "date" {
}

resource "aws_iam_policy" "bedrock_policy" {
  name        = "${local.name}Policy"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
                "bedrock:GetFoundationModel",
                "bedrock:ListFoundationModels",
                "bedrock:InvokeModel",
                "bedrock:InvokeModelWithResponseStream",
                "bedrock:ListTagsForResource",
                "bedrock:UntagResource",
                "bedrock:TagResource",
                "bedrock:CreateProvisionedModelThroughput",
                "bedrock:GetProvisionedModelThroughput",
                "bedrock:ListProvisionedModelThroughputs",
                "bedrock:UpdateProvisionedModelThroughput",
                "bedrock:DeleteProvisionedModelThroughput"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "bedrock_role" {
  name = "${local.name}Role"

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

resource "aws_iam_role_policy_attachment" "role_bedrock_policy_attachment" {
  role       = aws_iam_role.bedrock_role.name
  policy_arn = aws_iam_policy.bedrock_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloud_watch_policy" {
  role       = aws_iam_role.bedrock_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}