output "role_arn" {
    value = aws_iam_role.sqs_role.arn
}

output "policy_arn" {
    value = aws_iam_policy.sqs_policy.arn
}


output "queues" {
    value = toset([
        for sqs in aws_sqs_queue.sqs : sqs.id
        ])

}

output "dead_letter"{
    value = aws_sqs_queue.sqs_dlq.id
}


