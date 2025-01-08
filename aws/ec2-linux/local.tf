locals {
    name = format("%s-%s", var.instance_name, formatdate("YYYYMMDDhhmmss", time_static.date.rfc3339))
    due = formatdate("YYYYMMDD", time_static.date.rfc3339)
    subnet = {
        "aws-self-service": "subnet-03c7132099ef65e79,subnet-06847c16c1496eab9,subnet-0decf9a0f6623f7b1",
        "workato-demo-shared-services": "subnet-0d75339567aca60a1,subnet-0a692e79a3324c8b8,subnet-0fdb86dba280ab175"
    }
}
