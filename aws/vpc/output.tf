output "vpc_id" {
    value = aws_vpc.main
}

output "vpc_private_subnets" {
    value = aws_subnet.private_subnets[*].id
}

output "vpc_public_subnets" {
    value = aws_subnet.public_subnets[*].id
}