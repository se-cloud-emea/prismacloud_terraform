# prismacloud_terraform

Working TF module to provision a compliance standard (with requirement and section), RQL search, saved search and policy from it that ties to the compliance standard.

The provider config file is/can be expected at the `.prismacloud_auth.json` file.
An example config structure can look like:
```
{
    "url": "api.eu.prismacloud.io", 
    "username": "yada_access_key", 
    "password": "yada_secret_key", 
    "protocol": "https"
}
```
Another config parameter might be necessary if you don't opt for access/secret key but rather username/pass, that'll be: `customer_name` and corresponding env variable `PRISMACLOUD_CUSTOMER_NAME`.
If you use access/secret key, that won't be necessary. 

Unless if you want to put the provider configs in a config file, then export your env var, similar to:

```
export PRISMACLOUD_USERNAME=yada_access_key
export PRISMACLOUD_PASSWORD=yada_secret_key
export PRISMACLOUD_URL=api.eu.prismacloud.io
export PRISMACLOUD_PROTOCOL=https
```

Full details at:
https://registry.terraform.io/providers/PaloAltoNetworks/prismacloud/latest/docs
