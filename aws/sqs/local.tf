locals {
    name = format("%s-%s", terraform.workspace, formatdate("YYYYMMDDhhmmss", time_static.date.rfc3339))
    due = formatdate("YYYYMMDD", time_static.date.rfc3339)
    sqs_names = split(",", var.sqs_queues_name)
}
