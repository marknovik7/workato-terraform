variable "region" {
    default = "us-east-1"
}

variable "owner" {
    default = "CS-OPS"
}

variable "profile" {
    default = "aws-self-service"
}

variable "vpc" {
}

variable "allowedHosts" {
    default = {
        "cidr" = ["18.176.45.101","3.66.45.94","13.215.42.244","34.226.132.221","3.65.225.246","13.236.115.248","34.196.38.33","13.113.30.44","52.74.226.121","18.141.131.114","52.193.168.95","18.198.249.58","54.253.214.156","52.5.142.59","13.238.90.15","52.54.43.157"]
    }
}