variable "region" {
    default = "us-east-1"
}

variable "owner" {
    default = "CS-OPS"
}

variable "bucket_name" {
    description = "Name of the Bucket"
}

variable "type" {
    default = "PoC"
}

variable "aws_profile" {
    default = "aws-self-service"
}
