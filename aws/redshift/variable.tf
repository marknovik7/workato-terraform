variable "region" {
    default = "us-east-1"
}

variable "owner" {
    default = "CS-OPS"
}

variable "type" {
    default = "PoC"
}

variable "username" {
    default = "redshift-username" 
}

variable "aws_profile" {
    default = "aws-self-service"
}

variable "cluster_name" {
    default = "default_name"
}

variable "vpc_id" {
    default = "vpc-0eea0eb410480902e"
}

variable "node_type" {
    default = "ra3.xlplus"
}

variable "cluster_subnet_group" {
    default = "self-service-subnet-group"
}