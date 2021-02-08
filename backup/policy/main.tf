resource "prismacloud_saved_search" "this" {
    name        = var.policy_name
    description = var.description
    search_id   = prismacloud_rql_search.this.search_id
    query       = prismacloud_rql_search.this.query
    time_range {
        relative {
            unit    = prismacloud_rql_search.this.time_range.0.relative.0.unit
            amount  = prismacloud_rql_search.this.time_range.0.relative.0.amount
        }
    }
}

resource "prismacloud_rql_search" "this" {
    search_type = var.search_type
    query       = var.rql_query
    limit       = var.rql_limit
    time_range {
        relative {
            unit    = var.time_range_query_unit
            amount  = var.time_range_query_amount
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
        criteria    = prismacloud_rql_search.this.search_id
        rule_type   = var.rule_type
        parameters  = {
            "savedSearch": true,
            "withIac": false,
        }
    }
    #compliance_metadata {
    #  section_id        = var.section_id
    #  compliance_id     = var.compliance_id
    #  requirement_id    = var.requirement_id
    #}
}