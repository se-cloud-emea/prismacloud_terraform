/*

This file contains all policies for the compliance framework requirement section "AWS EC2" of the requirement "Standard Building Block".

*/

module "pag_sbb_ec2_keypair" {
  source            = "git::https://highway.porsche.com/bitbucket/scm/ccbb/prisma-cloud-customizations_modules.git//policy//"

  policy_name       = "EC2 Keypair usage is not allowed"
  remediation       = "The creation is globally forbidden. Please use Systems Manager - Session Manager as an alternative. Details can be found here: https://cloudcity.web.porsche.biz/"
  description       = "The usage of EC2 keypairs is not allowed to prevent the usage of SSH. Please use AWS Systems Manager - Session Manager to access EC2 instances."
  rql_query         = "config from cloud.resource where api.name = 'aws-ec2-key-pair' AND json.rule = keyName exists"
  #section_id        = prismacloud_compliance_standard_requirement_section.CSRS_PAG_SBB_EC2.csrs_id
  #requirement_id    = prismacloud_compliance_standard_requirement.CSR_PAG_SBB.csr_id
  #compliance_id     = prismacloud_compliance_standard.CS_PAG.cs_id
}
