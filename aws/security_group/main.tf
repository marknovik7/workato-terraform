data "aws_vpc" "workato_vpc" {
  id = var.vpc
}


resource "aws_security_group" "workato_default_security_group" {
  name        = "Workato Default Security Group"
  description = "Allow Access only to Workato Central and the AWS VPN"
  vpc_id      = data.aws_vpc.workato_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "sg_ingress_rules" {

  for_each = local.allowedHosts
  security_group_id = aws_security_group.workato_default_security_group.id
  cidr_ipv4         = each.value.cidr_block
  description       = each.value.description 
  from_port         = "-1"
  ip_protocol       = "-1"
  to_port           = "-1"
}

resource "aws_vpc_security_group_egress_rule" "sg_egress" {
  security_group_id = aws_security_group.workato_default_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "time_static" "date" {
}

data "aws_default_tags" "sg_default_tags" {}
