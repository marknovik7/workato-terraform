resource "aws_sqs_queue" "sqs_dlq" {
    name = "dead-letter"

}

resource "aws_sqs_queue" "sqs_dlq_fifo" {
    name = "dead-letter.fifo"
    fifo_queue = true

}

resource "aws_sqs_queue" "sqs" {
    fifo_queue = element(var.sqs_queues_name,count.index ).fifo
    count = length(var.sqs_queues_name)
    name = format("%s%s",element(var.sqs_queues_name,count.index ).name,(element(var.sqs_queues_name,count.index ).fifo? ".fifo" : ""))
    redrive_policy = jsonencode({
    deadLetterTargetArn = element(var.sqs_queues_name,count.index ).fifo? aws_sqs_queue.sqs_dlq_fifo.arn : aws_sqs_queue.sqs_dlq.arn
    maxReceiveCount     = 4
  })

}

resource "time_static" "date" {
}

resource "aws_iam_policy" "sqs_policy" {
  name        = "SQS-${local.name}_policy"
  description = "Allow "

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
                  "sqs:ReceiveMessage",
                  "sqs:DeleteMessage",
                  "sqs:GetQueueAttributes",
                  "sqs:SendMessage",
                  "sqs:ListQueueTags"
        ]
        "Resource": concat([for sqs in aws_sqs_queue.sqs : sqs.arn],[aws_sqs_queue.sqs_dlq.arn])
      }, 
      {
        "Effect" : "Allow",
        "Action" : [
                  "sqs:ListQueues",
                  "iam:ChangePassword "
        ]
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role" "sqs_role" {
  name = "SQS_${local.name}_role"

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

resource "aws_iam_user" "user" {
  name          = "${terraform.workspace}"
  path          = "/sqs/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "user" {
  user    = "${aws_iam_user.user.name}"
  pgp_key = "keybase:torimpo"
  password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.sqs_policy.arn
}