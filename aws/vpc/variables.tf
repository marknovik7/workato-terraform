variable "owner" {
    default = "CS-OPS"
}

variable "application" {
    default = "Walnut-bot"
}

variable "region" {
    default = "us-east-1"
}

variable "name" {
    default = "walnut-bot-prod"
}

variable "vpc_name" {
    default = "vpc-walnut-bot"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
 
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "profile" {
    default = "aws-self-service"
}