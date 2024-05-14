output "instance_ip_addr" {
    value = aws_instance.opa_instance.public_ip
}

output "instance_id" {
    value = aws_instance.opa_instance.id
}

output "instance_name" {
    value = local.name
}

output "instance_username"{
    value = var.instance_username
}
output "ami-id" {
    value = aws_instance.opa_instance.ami
}

output "Password" {
    value = random_password.password.result
     sensitive = true
 }

