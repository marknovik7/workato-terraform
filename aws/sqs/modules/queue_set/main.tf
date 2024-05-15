variable "name" {
  type = string
}

variable "dlq_arn" {
    type = string
    default = ""
}

resource "aws_sqs_queue" "sqs" {
    name = var.name
    redrive_policy = jsonencode({
    deadLetterTargetArn = var.dlq_arn
    maxReceiveCount     = 4
  })

}

output id {
    value = "${aws_sqs_queue.sqs.id}"
}

output arn {
    value = "${aws_sqs_queue.sqs.arn}"
}