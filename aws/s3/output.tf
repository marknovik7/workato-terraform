output "role_arn" {
    value = aws_iam_role.bucket_role.arn
}

output "policy_arn" {
    value = aws_iam_policy.bucket_policy.arn
}


output "bucket_domain_name" {
    value = aws_s3_bucket.bucket.bucket_domain_name
}

output username {
    value = aws_iam_user.user.name
}

# output "password" {
#   value = "${aws_iam_user_login_profile.user.encrypted_password}"
#   sensitive = true
# }

output "kms_key" {
  value = "${data.aws_kms_alias.shared_kms_key.arn}"
}

