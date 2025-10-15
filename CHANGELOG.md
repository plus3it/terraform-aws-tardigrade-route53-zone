## terraform-aws-tardigrade-route53-subzone Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).


### [4.2.1](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/releases/tag/4.2.1)

**Released**: 2025.10.15

**Summary**:

*   Adds health check functionality to record and a test to validate

### [4.2.0](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/releases/tag/4.2.0)

**Released**: 2025.10.14

**Summary**:

*   Adds a new submodule for the Route53 record resource
*   Removes terragrunt style path references

### [4.1.1](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/releases/tag/4.1.1)

**Released**: 2023.08.04

**Summary**:

*   Uses lifecycle ignore_changes on the vpc to avoid removing vpcs associated in a separate config

### [4.1.0](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/releases/tag/4.1.0)

**Released**: 2023.06.20

**Summary**:

*   Add support for creating prizate zones, sub-zones, and cross account vpc association

### 4.0.0

**Released**: 2021.10.08

**Commit Delta**: [Change from 3.0.1 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/3.0.1...4.0.0)

**Summary**:

*   Upgrade to terraform 0.15.x

### 3.0.1

**Released**: 2021.04.30

**Commit Delta**: [Change from 3.0.0 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/3.0.0...3.0.1)

**Summary**:

*   Removes extraneous provider blocks from tests
*   Add a required_providers block with a minimum version for the aws provider

### 3.0.0

**Released**: 2020.12.20

**Commit Delta**: [Change from 2.0.0 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/2.0.0...3.0.0)

**Summary**:

*   Generates a stable random value from null_data_source and null_resource
*   Increases timeout for tests
*   Removes module-wide create/enable variables

### 2.0.0

**Released**: 2020.06.26

**Commit Delta**: [Change from 1.1.1 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/1.1.1...2.0.0)

**Summary**:

*   Updates main module to use submodules for all use cases
*   Adds test for delegation module and all main module use cases
*   Rewrites test for route53 query log, zone creation, query log with kms
*   Creates submodule for managing route53 query log
*   Creates submodule for managing route53 delegation
*   Creates submodule for managing route53 zone

### 1.1.1

**Released**: 2020.06.05

**Commit Delta**: [Change from 1.1.0 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/1.1.0...1.1.1)

**Summary**:

*   Uses region instead of partion for ViaService value

### 1.1.0

**Released**: 2020.06.05

**Commit Delta**: [Change from 1.0.2 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/1.0.2...1.1.0)

**Summary**:

*   Removes unnecessary decrypt permission
*   Adds test for kms-encrypted bucket configs
*   Supports query logging when bucket encryption is configured
*   Updates testing framework''s search for terraform files
*   Updates CI/CD files, including the use of tardigrade-ci
*   Converts the Terraform-related _doc/MAIN.md files to README.md files
*   Updates Terraform information in README.md to use format expected by tardigrade-ci''s use of terraform-docs

### 1.0.2

**Released**: 2019.10.28

**Commit Delta**: [Change from 1.0.1 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/1.0.1...1.0.2)

**Summary**:

*   Pins tfdocs-awk version
*   Updates documentation generation make targets
*   Adds documentation to the test modules

### 1.0.1

**Released**: 2019.10.03

**Commit Delta**: [Change from 1.0.0 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/1.0.0...1.0.1)

**Summary**:

*   Update testing harness to have a more user-friendly output
*   Update terratest dependencies

### 1.0.0

**Released**: 2019.09.11

**Commit Delta**: [Change from 0.0.0 release](https://github.com/plus3it/terraform-aws-tardigrade-route53-subzone/compare/0.0.0...1.0.0)

**Summary**:

*   Upgrade to terraform 0.12.x
*   Add test cases

### 0.0.0

**Commit Delta**: N/A

**Released**: 2019.09.03

**Summary**:

*   Initial release!
