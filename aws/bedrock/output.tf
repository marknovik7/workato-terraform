output "role_arn" {
    value = aws_iam_role.bedrock_role.arn
}

output "policy_arn" {
    value = aws_iam_policy.bedrock_policy.arn
}

