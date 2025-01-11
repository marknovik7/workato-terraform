resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


resource "aws_redshift_cluster" "dw_cluster" {
  cluster_identifier = replace(var.cluster_name, "_", "-")
  database_name      = "workato-demo"
  master_username    = var.username
  master_password    = random_password.password.result
  node_type          = var.node_type
  cluster_type       = "single-node"
  publicly_accessible = "true"
  encrypted         = true
  enhanced_vpc_routing = true
  vpc_security_group_ids = data.aws_security_groups.workato_security_group.ids
  cluster_subnet_group_name = var.cluster_subnet_group
  skip_final_snapshot  = true

}

data "aws_security_groups" "workato_security_group" {
  filter {
    name   = "group-name"
    values = ["Workato Default Security Group"]
  }

  filter {
    name = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_kms_alias" "shared_kms_key" {
  name = "alias/shared-kms-key"
}

resource "time_static" "date" {
}