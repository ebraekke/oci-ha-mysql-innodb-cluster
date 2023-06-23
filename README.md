# oci-ha-mysql-innodb-cluster

A practical implementation of [Deploy a highly available MySQL InnoDB cluster](https://docs.oracle.com/en/solutions/ha-mysql-innodb-cluster/index.html) on Oracle's reference architecture website. 

A pdf copy of the page can be found in the [doc folder](doc/Deploy-a-highly-available-MySQL-InnoDB-cluster.pdf).

## Create

terraform plan --out=ha.tfplan --var-file=config/vars_arn.tfvars

terraform apply ...

