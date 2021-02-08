terraform {
  required_providers {
    prismacloud = {
      source = "PaloAltoNetworks/prismacloud"
      version = "1.1.0"
    }
  }
}

# Configure the prismacloud provider
provider "prismacloud" {
    json_config_file = ".prismacloud_auth.json"
}

resource "prismacloud_compliance_standard" "CS_PAG" {
    name = "Porsche AG"
    description = "Compliance Standards Porsche AG"
}

resource "prismacloud_compliance_standard_requirement" "CSR_PAG_BB" {
    cs_id = prismacloud_compliance_standard.CS_PAG.cs_id
    name = "PAG - Building Blocks"
    description = "PAG Building Blocks"
    requirement_id = "PAG Building Blocks"
}

resource "prismacloud_compliance_standard_requirement_section" "CSRS_PAG_BB_EC2" {
    csr_id = prismacloud_compliance_standard_requirement.CSR_PAG_BB.csr_id
    section_id = "EC2"
    description = "Requirement Section for EC2"
}

resource "prismacloud_rql_search" "x" {
    search_type = "config"
    query = "config from cloud.resource where api.name = 'aws-ec2-key-pair' AND json.rule = keyName exists"
    time_range {
        relative {
            unit = "hour"
            amount = 24
        }
    }
}

resource "prismacloud_saved_search" "example" {
    name = var.policy_name
    description = var.description
    search_id = prismacloud_rql_search.x.search_id
    query = prismacloud_rql_search.x.query
    time_range {
        relative {
            unit = prismacloud_rql_search.x.time_range.0.relative.0.unit
            amount = prismacloud_rql_search.x.time_range.0.relative.0.amount
        }
    }
}

resource "prismacloud_policy" "this" {
    name                        = var.policy_name
    policy_type                 = var.policy_type
    description                 = var.description
    recommendation              = var.remediation
    restrict_alert_dismissal    = var.restrict_alert_dismissal
    enabled                     = var.enabled
    severity                    = var.policy_severity
    cloud_type                  = var.policy_cloud
    rule {
        name        = var.policy_name
        criteria    = prismacloud_saved_search.example.search_id
        rule_type   = var.rule_type
        parameters  = {
            "savedSearch": true,
            "withIac": false,
        }
    }
    compliance_metadata {
      compliance_id     = prismacloud_compliance_standard_requirement_section.CSRS_PAG_BB_EC2.csrs_id
      custom_assigned = true
      requirement_id = prismacloud_compliance_standard_requirement.CSR_PAG_BB.requirement_id
      requirement_name = prismacloud_compliance_standard_requirement.CSR_PAG_BB.name
      section_id = prismacloud_compliance_standard_requirement_section.CSRS_PAG_BB_EC2.section_id
      standard_name = prismacloud_compliance_standard.CS_PAG.name
      #compliance_id     = prismacloud_compliance_standard.CS_PAG.cs_id
      #requirement_id    = prismacloud_compliance_standard_requirement.CSR_PAG_BB.csr_id
      #section_id        = prismacloud_compliance_standard_requirement_section.CSRS_PAG_BB_EC2.csrs_id
    }
}
