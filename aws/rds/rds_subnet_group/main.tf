data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.name
  subnet_ids = toset(data.aws_subnets.subnets.ids)

}

resource "time_static" "date" {
}
