output jdbc {
  value = aws_redshift_cluster.dw_cluster.endpoint
}

output databasename {
  value = aws_redshift_cluster.dw_cluster.database_name
}

output username {
    value = var.username
}

output "password" {
  value = random_password.password.result
  sensitive = true
}

output "kms_key" {
  value = "${data.aws_kms_alias.shared_kms_key.arn}"
}

