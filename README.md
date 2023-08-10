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

## Read config files to create Bastion Sessions 


```powershell 
fileContent = Get-Content .\README.md
forEach ($compute_ocid in (Get-Content $fileContent)) {
  echo $compute_ocid

  ## Do this in a try-catch block for X minutes for each of the 
  ## oci instance-agent plugin get -c $compartment_ocid --instanceagent-id $compute_ocid --plugin-name Bastion
  
}
```

## Inspiration 

https://github.com/oracle-quickstart/oci-crowdstrike/blob/main/sample-ansible

Private Endpoint 
https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/resourcemanager_private_endpoint

IP of the private endpoint 
https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/resourcemanager_private_endpoint_reachable_ip

## Troubleshooting Bastion Plugins

The Bastion plugin used for managed ssh sessions may "act up".
Typically this is due to a delay in startup time.  

I have not found a way to `WAIT-FOR` the completion of the plugin startup as this seems to be happening asynchronously from
the request to create the instance.  

I have also found that the instance needs to be (1) on a private subnet with a route to the OCI Service Gateway or 
(2) on a public subnet with a public address. Probably obvious, I know, but I did take me some time to figure out. 

```shell
oci instance-agent plugin get -c $compartment_ocid --instanceagent-id $compute_ocid --plugin-name Bastion
<<
{
  "data": {
    "message": null,
    "name": "Bastion",
    "status": "RUNNING",
    "time-last-updated-utc": "2023-06-29T11:34:25.076000+00:00"
  }
```

```powershell
Get-OCIComputeinstanceagentInstanceAgentPlugin -CompartmentId $compartment_ocid -InstanceagentId $compute_ocid -PluginName Bastion
<<
Name     Status TimeLastUpdatedUtc  Message
----     ------ ------------------  -------
Bastion Running 29.06.2023 11:34:25
```

### Error in service call before started 

You will get an error like this before the agent has started properly. This can take take several minutes.
```PowerShell
❯  Get-OCIComputeinstanceagentInstanceAgentPlugin -CompartmentId $compartment_ocid -InstanceagentId $compute_ocid -PluginName Bastionn
Get-OCIComputeinstanceagentInstanceAgentPlugin: Error returned by Plugin Service. Http Status Code: 400. ServiceCode: InvalidParameter. OpcRequestId: /A702038F4A5A152227708974F5301655/0176F79D2CBA60312C5A9E769F4F1CCC. Message: Plugin Bastionn not present for instance ocid1.instance.oc1.eu-stockholm-1.anqxeljr3gkdkiacjztrigqyatft76zxigxnfowdh7f4anj5pqoksgqcztlq
Operation Name: GetInstanceAgentPlugin
TimeStamp: 2023-06-29T14:39:18.598Z
Client Version: Oracle-DotNetSDK/64.2.0 (Win32NT/10.0.19045.0; .NET 7.0.8)  Oracle-PowerShell/60.2.0
Request Endpoint: GET https://iaas.eu-stockholm-1.oraclecloud.com/20180530/instanceagents/ocid1.instance.oc1.eu-stockholm-1.anqxeljr3gkdkiacjztrigqyatft76zxigxnfowdh7f4anj5pqoksgqcztlq/plugins/Bastionn?compartmentId=ocid1.compartment.oc1..aaaaaaaaczweti6jsgswmtxm6hgfs6mdakb3asdsguuixnj47zd7frgln2jq
For details on this operation's requirements, see https://docs.oracle.com/iaas/api/#/en/instanceagent/20180530/Plugin/GetInstanceAgentPlugin.
Get more information on a failing request by using the -Verbose or -Debug flags. See https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/powershellconcepts.htm#powershellconcepts_topic_logging
For more information about resolving this error, see https://docs.oracle.com/en-us/iaas/Content/API/References/apierrors.htm#apierrors_400__400_invalidparameter
If you are unable to resolve this Plugin issue, please contact Oracle support and provide them this full error message.
```
