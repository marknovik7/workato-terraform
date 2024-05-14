output "instance_ip_addr" {
    value = aws_instance.opa_instance.public_ip
}

output "instance_id" {
    value = aws_instance.opa_instance.id
}

output "instance_name" {
    value = local.name
}

output "pem_file" {
    value = tls_private_key.opa_key.private_key_pem
    sensitive = true
}

output "ami-id" {
    value = aws_instance.opa_instance.ami
}

