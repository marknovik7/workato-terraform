variable "ami" {
    default = "ami-0cd8217d39da92e6d"
}

variable "region" {
    default = "us-east-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "subnet" {
    default = "subnet-0ba7005370e286b34"
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

