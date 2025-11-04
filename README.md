# oci-ha-mysql-innodb-cluster

A practical implementation of [Deploy a highly available MySQL InnoDB cluster](https://docs.oracle.com/en/solutions/ha-mysql-innodb-cluster/index.html) on Oracle's reference architecture website. 

A pdf copy of the page can be found in the [doc folder](doc/Deploy-a-highly-available-MySQL-InnoDB-cluster.pdf).

## Now OpenTofu

```powershell
tofu --version

OpenTofu v1.10.6
...
```

## You must add your own provider file 

Add your provider specification as `local_provider.tf` to the top level directory: 
```terraform
# file is outside of source control, hardcode your values
## DO NOT include in zip file
provider "oci" {
#  alias = "local"

  region              = var.region
  auth                = "SecurityToken"
  config_file_profile = var.oci_cli_profile
}
```

## 
