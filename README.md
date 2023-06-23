# oci-ha-mysql-innodb-cluster

A practical implementation of [Deploy a highly available MySQL InnoDB cluster](https://docs.oracle.com/en/solutions/ha-mysql-innodb-cluster/index.html) on Oracle's reference architecture website. 

A pdf copy of the page can be found in the [doc folder](doc/Deploy-a-highly-available-MySQL-InnoDB-cluster.pdf).

## Create

terraform plan --out=ha.tfplan --var-file=config/vars_arn.tfvars

terraform apply ...


## Find base image in posh

```
oci compute image list -c $C --all --query 'data[*].{Name:"display-name",OCID:id}' --output table
<<
+---------------------------------------+---------------------------------------------------------------------------------------------+
| Name                                  | OCID                                                                                        |
+---------------------------------------+---------------------------------------------------------------------------------------------+
| Oracle-Linux-9.1-aarch64-2023.03.28-0 | ocid1.image.oc1.eu-stockholm-1.aaaaaaaajql7wwcojm5tsayta3vksyowaove3lvt4bpbkxid57xuctf3sq6q |
| Oracle-Linux-9.1-2023.03.28-0         | ocid1.image.oc1.eu-stockholm-1.aaaaaaaaaozvprtafwubfaxavd7hwkquptkhuw2qrrvkwilef6ompjf2wwka |
+---------------------------------------+---------------------------------------------------------------------------------------------+
```
