locals {
    name = format("%s-%s", var.cluster_name, formatdate("YYYYMMDDhhmmss", time_static.date.rfc3339))
    due = formatdate("YYYYMMDD", time_static.date.rfc3339)
}