# terraform-aws-tardigrade-route53-subzone

Terraform module to create Route53 subzone and and setup delegation for that subzone. This module assumes that you already have a Route53 hosted zone and so this module will simply setup a subzone of that parent zone. The module is also capable of setting up query logging for that subzone but that is disabled by default. If you would like the query logging to be enabled, set the variable `create_route53_query_log` to `true`
