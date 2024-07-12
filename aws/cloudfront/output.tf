output "bucket_domain_name" {
    value = aws_s3_bucket.bucket.bucket_domain_name
}

output "bucket" {
    value = aws_s3_bucket.bucket.id
}
output "bucket_arn" {
    value = aws_s3_bucket.bucket.arn
}

