/*

This file contains all policies for the compliance framework requirement section "AWS ECR" of the requirement "Standard Building Block".

*/

module "pag_sbb_ecr_tag_immutable" {
  source            = "git::https://highway.porsche.com/bitbucket/scm/ccbb/prisma-cloud-customizations_modules.git//policy//"

  policy_name       = "ECR Tag Immutability"
  remediation       = "Details can be found here: https://cloudcity.web.porsche.biz/ or https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-tag-mutability.html"
  description       = "Please do not use 'latest' tag, instead use immutable tags. This helps to identify on which code base to container is based on"
  rql_query         = "config where cloud.type = 'aws' AND api.name = 'aws-ecr-get-repository-policy' AND json.rule = imageTagMutability equals 'IMMUTABLE'"
  #section_id        = prismacloud_compliance_standard_requirement_section.CSRS_PAG_SBB_ECR.csrs_id
  #requirement_id    = prismacloud_compliance_standard_requirement.CSR_PAG_SBB.csr_id
  #compliance_id     = prismacloud_compliance_standard.CS_PAG.cs_id
}

module "pag_sbb_ecr_scan" {
  source            = "git::https://highway.porsche.com/bitbucket/scm/ccbb/prisma-cloud-customizations_modules.git//policy//"

  policy_name       = "ECR Scan On Push"
  remediation       = "Details can be found here: https://cloudcity.web.porsche.biz/ or https://docs.aws.amazon.com/AmazonECR/latest/userguide/image-scanning.html"
  description       = "Container must be scanned for vulnerabilities. AWS ECR provides this feature via 'scan on push'"
  rql_query         = "config where cloud.type = 'aws' AND api.name = 'aws-ecr-get-repository-policy' AND json.rule = imageScanningConfiguration.scanOnPush is false"
  #section_id        = prismacloud_compliance_standard_requirement_section.CSRS_PAG_SBB_ECR.csrs_id
  #requirement_id    = prismacloud_compliance_standard_requirement.CSR_PAG_SBB.csr_id
  #compliance_id     = prismacloud_compliance_standard.CS_PAG.cs_id
}

module "pag_sbb_ecr_remove_vulnerabilities" {
  source            = "git::https://highway.porsche.com/bitbucket/scm/ccbb/prisma-cloud-customizations_modules.git//policy//"

  policy_name       = "ECR Remove Vulnerabilities"
  remediation       = "Please update dependencies in your container to address the findings"
  description       = "The container should be free on known vulnerabilities to reduce attack surface"
  rql_query         = "config from cloud.resource where api.name = 'aws-ecr-image' AND json.rule = imageScanFindingsSummary exists"
  #section_id        = prismacloud_compliance_standard_requirement_section.CSRS_PAG_SBB_ECR.csrs_id
  #requirement_id    = prismacloud_compliance_standard_requirement.CSR_PAG_SBB.csr_id
  #compliance_id     = prismacloud_compliance_standard.CS_PAG.cs_id
}