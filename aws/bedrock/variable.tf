variable "region" {
    default = "us-east-1"
}

variable "owner" {
    default = "CS-OPS"
}

variable "type" {
    default = "PoC"
}

variable "aws_account_id" {
    default = "353360065216"
    description = "Workato ID"
}

variable "workato_iam_external_id" {
    default = "NONE"
    description = "Complete with workato_iam_external_id_<workspace_id>"
}

variable "aws_profile" {
    default = "aws-self-service"
}

