output "rds_subnet_group_id" {
    value =  aws_db_subnet_group.rds_subnet_group.id
}

output "rds_subnet_group_arn" {
    value =  aws_db_subnet_group.rds_subnet_group.arn
}