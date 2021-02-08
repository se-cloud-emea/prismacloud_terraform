# prismacloud_terraform

Working TF module to provision a compliance standard (with requirement and section), RQL search, saved search and policy from it that ties to the compliance standard.

The provider config file is/can be expected at: .prismacloud_auth.json

Unless if you want to put the provider configs in a config file, then export your env var, similar to:

export PRISMACLOUD_USERNAME=yada
export PRISMACLOUD_PASSWORD=yada
export PRISMACLOUD_URL=api.eu.prismacloud.io
export PRISMACLOUD_PROTOCOL=https

Full details at:
https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs