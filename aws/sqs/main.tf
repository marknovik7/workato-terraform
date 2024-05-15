# resource "aws_sqs_queue" "sqs" {

#   foreach = toset(split(",", var.sqs_queues))

#   name = each.value
  
# }
resource "aws_sqs_queue" "sqs_dlq" {
    name = "dead-letter"
}

module queue_set {
  source = "./modules/queue_set"

  for_each = toset(split(",", var.sqs_queues_name))
  
  name = each.value
  dlq_arn = aws_sqs_queue.sqs_dlq.arn

}

resource "time_static" "date" {
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "SQS-${local.name}-_policy"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
                  "sqs:ReceiveMessage",
                  "sqs:DeleteMessage",
                  "sqs:ListQueues",
                  "sqs:GetQueueAttributes",
                  "sqs:SendMessage"
        ]
        "Resource": [for sqs in module.queue_set : sqs.arn]
      }
    ]
  })
}

resource "aws_iam_role" "sqs_role" {
  name = "${local.name}_role"

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

resource "aws_iam_role_policy_attachment" "role_sqs_policy_attachment" {
  role       = aws_iam_role.sqs_role.name
  policy_arn = aws_iam_policy.sqs_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloud_watch_policy" {
  role       = aws_iam_role.sqs_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}