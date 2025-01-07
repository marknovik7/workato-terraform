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

variable "aws_account_id" {
    default = "353360065216"
    description = "Workato ID"
}

variable "description" {
  description = "Description of the S3 bucket"
  type        = string
}

variable "workato_iam_external_id" {
    description = "Complete with workato_iam_external_id_<workspace_id>"
}

variable "aws_profile" {
    default = "aws-self-service"
}

variable "pgp_key" {
    default = "svc_tfo"
    description = "pgp key"
}

variable "owner" {
  type = string
}
