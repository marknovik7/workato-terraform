locals {
    name = format("bedrock-%s", formatdate("YYYYMMDDhhmmss", time_static.date.rfc3339))
    due = formatdate("YYYYMMDD", time_static.date.rfc3339)
}
