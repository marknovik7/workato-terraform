output "role_arn" {
    value = aws_iam_role.kms_role.arn
}

output "policy_arn" {
    value = aws_iam_policy.kms_policy.arn
}

