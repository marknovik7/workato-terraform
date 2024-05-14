variable "ami" {
    default = "NONE"
}

variable "region" {
    default = "us-east-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet" {
    default = {
        "aws-self-service": "subnet-03c7132099ef65e79,subnet-06847c16c1496eab9,subnet-0decf9a0f6623f7b1",
        "workato-demo-shared-services": "subnet-0d75339567aca60a1,subnet-0a692e79a3324c8b8,subnet-0fdb86dba280ab175"
    }
}

variable "owner" {
    default = "CS-OPS"
}

variable "instance_username" {
    default = "cs-ops"
}

variable "VOLUME_SIZE" {
    default = 30

}

variable "VOLUME_TYPE" {
    default = "gp2"
}

variable "instance_name" {
    default = "default-linux-opa-test"
}

variable "type" {
    default = "PoC"
}

variable "new_cert" {
    default = true
    type = bool
}

variable "profile" {
    default = "aws-self-service"
}

variable "security_group_id" {
    default = "sg-0daaafb9fd50a631b"
}
