output "role_name" {
    value = aws_iam_role.bucket_role.name
}

output "policy_name" {
    value = aws_iam_policy.bucket_policy.name
}


output "bucket_name" {
    value = aws_s3_bucket.bucket
}


