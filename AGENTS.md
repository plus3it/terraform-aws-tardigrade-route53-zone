# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module creates a Route53 hosted zone. It can also create the zone's DNSSEC signing, a query log configuration, NS delegation records in another zone, and DNS records. The main input is `name`, and the optional inputs `dnssec`, `records`, `vpcs`, `create_route53_query_log` and `create_route53_delegation` turn on the extra features. The main outputs are `id`, `name`, `name_servers`, `dnssec` and `records`.

### Module-specific files

- `modules/delegation/`: Creates the NS delegation records for a sub-zone in the name server zone. The root module calls it with the `aws.ns` provider.
- `modules/dnssec/`: Creates the KMS key and alias, the key signing key, and the hosted zone DNSSEC resource. The root module calls it.
- `modules/query-log/`: Creates the CloudWatch log group, the Route53 query log, and the IAM roles and Kinesis Firehose delivery stream that ship the logs. The root module calls it.
- `modules/record/`: Creates one Route53 record. The root module calls it once for each entry in `records`.
- `modules/vpc_association/`: Creates the VPC association authorization and the zone association for a private zone, using an `aws.vpc_owner` provider. The root module does not call it. Consumers call it directly.
- `modules/zone/`: Creates the Route53 hosted zone. The root module calls it.
