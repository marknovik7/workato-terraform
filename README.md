# Terraform Scripts for AWS Resources

This repository contains Terraform scripts to provision various AWS resources like S3 buckets, EC2 Linux instances, and EC2 Windows instances. Below are the required inputs that users need to pass from the workflow for each resource type.

## Schema of Inputs

### S3 Bucket Inputs

Example:
```json
{
  "bucket_name": "workato-yash-test-bucket",
  "owner": "CS-OPS",
  "workato_iam_external_id": "324423",
  "end_date": "23-01-2025",
  "jira_ticket_id": "ID_Q21WSQDSDXS"
}
```

#### Fields:

| Field                    | Description                               | Type    | Default Value      | User Input Field / Default Value Provided |
|--------------------------|-------------------------------------------|---------|--------------------|------------------------------------------|
| `region`                 | AWS region                                | string  | `us-east-1`        | Default Value Provided                   |
| `owner`                  | Owner of the resource                     | string  | `CS-OPS`           | User Input Field                         |
| `bucket_name`            | Name of the Bucket                        | string  | `<Bucket-Name>`    | User Input Field                         |
| `type`                   | Type of the resource                      | string  | `PoC`              | Default Value Provided                   |
| `aws_account_id`         | Workato ID                                | string  | `353360065216`     | Default Value Provided                   |
| `workato_iam_external_id`| Workato IAM External ID                   | string  | `<External-ID>`    | User Input Field                         |
| `pgp_key`                | PGP key                                   | string  | `svc_tfo`          | Default Value Provided                   |
| `jira_ticket_id`         | Jira Ticket ID                            | string  | null               | User Input Field                         |
| `end_date`               | End date for the resource                 | string  | null               | User Input Field                         |

### EC2-Linux Inputs

Example:
```json
{
  "instance_type": "t2.micro",
  "owner": "CS-OPS",
  "VOLUME_SIZE": 80,
  "instance_name": "yash-linux-opa-test",
  "end_date": "23-01-2025",
  "jira_ticket_id": "JIRAID123"
}
```

#### Fields:

| Field            | Description                              | Type    | Default Value           | User Input Field / Default Value Provided |
|------------------|------------------------------------------|---------|-------------------------|------------------------------------------|
| `region`         | AWS region                               | string  | `us-east-1`             | Default Value Provided                   |
| `instance_type`  | Type of the EC2 instance                 | string  | `t2.micro`              | User Input Field                         |
| `owner`          | Owner of the resource                    | string  | `CS-OPS`                | User Input Field                   |
| `VOLUME_SIZE`    | Size of the volume in GB                 | number  | 15                      | User Input Field                         |
| `VOLUME_TYPE`    | Type of the volume                       | string  | `gp2`                   | Default Value Provided                   |
| `instance_name`  | Name of the instance                     | string  | `linux-opa-test`        | User Input Field                         |
| `type`           | Type of the resource                     | string  | `PoC`                   | Default Value Provided                   |
| `new_cert`       | Whether to generate a new certificate    | boolean | true                    | Default Value Provided                   |
| `subnet_id`      | Subnet ID                                | string  | null                    | Default Value Provided                   |
| `security_group_id` | Security Group ID                     | string  | `sg-0daaafb9fd50a631b`  | Default Value Provided                   |
| `end_date`       | End date for the instance                | string  | null                    | User Input Field                         |
| `jira_ticket_id` | Jira Ticket ID                           | string  | null                    | User Input Field                         |

### EC2-Windows Inputs

Example:
```json
{
  "instance_type": "t2.medium",
  "owner": "CS-OPS",
  "VOLUME_SIZE": 80,
  "VOLUME_TYPE": "gp3",
  "instance_name": "yash-linux-opa-test",
  "type": "PoC",
  "jira_ticket_id": "JIRAID123"
}
```

#### Fields:

| Field            | Description                              | Type    | Default Value           | User Input Field / Default Value Provided |
|------------------|------------------------------------------|---------|-------------------------|------------------------------------------|
| `region`         | AWS region                               | string  | `us-east-1`             | Default Value Provided                   |
| `instance_type`  | Type of the EC2 instance                 | string  | `t2.micro`              | User Input Field                         |
| `owner`          | Owner of the resource                    | string  | `CS-OPS`                | Default Value Provided                   |
| `VOLUME_SIZE`    | Size of the volume in GB                 | number  | 30                      | User Input Field                         |
| `VOLUME_TYPE`    | Type of the volume                       | string  | `gp2`                   | User Input Field                         |
| `instance_name`  | Name of the instance                     | string  | `default-linux-opa-test`| User Input Field                         |
| `type`           | Type of the resource                     | string  | `PoC`                   | Default Value Provided                   |
| `new_cert`       | Whether to generate a new certificate    | boolean | true                    | Default Value Provided                   |
| `subnet`         | Subnet ID                                | string  | ""                      | Default Value Provided                   |
| `vpc_name`       | VPC Name                                 | string  | ""                      | Default Value Provided                   |
| `security_group_id` | Security Group ID                     | string  | `sg-0daaafb9fd50a631b`  | Default Value Provided                   |
| `jira_ticket_id` | Jira Ticket ID                           | string  | null                    | User Input Field                         |

## Usage

To use these Terraform scripts, ensure you provide the required inputs as specified in the schema above.