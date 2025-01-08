variable "ami" {
    default = "NONE"
}

variable "region" {
    default = "us-east-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "owner" {
    default = "CS-OPS"
}

variable "VOLUME_SIZE" {
    default = 15

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

variable "subnet_id" {
    default = null
}
variable "security_group_id" {
    default = "sg-0daaafb9fd50a631b"
}
