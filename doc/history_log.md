## Available images

```
| Oracle-Linux-9.6-aarch64-2025.10.23-0                 | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaajhocvizgu5klrtuyan37c673t5x2b34fs45x3ojxen7c4oo2nrbq |
| Oracle-Linux-9.6-aarch64-2025.09.16-0                 | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaalrgdrwmkpxxin7n63n6wv24dwafh444hh4az2wsq5czqli7ik6xq |
| Oracle-Linux-9.6-aarch64-2025.08.31-0                 | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaa33o54javaysebvmgwgcjzkwqj6iniljplyv2bo55dnlqo5csj3q |
| Oracle-Linux-8.10-aarch64-2025.10.23-0                | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa5l2ht46sdih2j2vrtugeqmi5opn45ostngzhe4z5rtdct7zcbmta |
| Oracle-Linux-8.10-aarch64-2025.09.16-0                | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaapbp4hdlf6xlfhzhc43ebgapapkhxafrk3b2agy3klskbsjq2x7oa |
| Oracle-Linux-8.10-aarch64-2025.08.31-0                | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaas6szggxbmvcu6s7i3li5jialqoqsaox2f52vywbuyk5zhfsqvbga |
| Oracle-Linux-8.10-Gen2-GPU-2025.08.31-0               | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaarbsqnsvucj366yn36ttbdjxs3pdg6vgviauw7vr7uofyx7bw7lza |


| Canonical-Ubuntu-24.04-aarch64-2025.09.26-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaawztrbuytfb3ko5qmyxo2omftxd63gq6rpgc43appmifmmdc5eq5q |
| Canonical-Ubuntu-24.04-aarch64-2025.07.23-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaanqexajytbn3qi2gn4i4c3ryo4afgtekjgslovyqxnkrpr56xtfka |
| Canonical-Ubuntu-24.04-aarch64-2025.05.20-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaxhdnngoowpuvwonng4mr2brdemk5wvmompn6ykmohmfuqmwvagjq |
| Canonical-Ubuntu-24.04-Minimal-aarch64-2025.09.22-0   | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaafb2sye3yjqkh3ejoeindkf2jgbgo2cciffs6sbwnpbgvclz6q5zq |
| Canonical-Ubuntu-24.04-Minimal-aarch64-2025.07.23-0   | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaqnd47pb5voquvoszcyk3fj4n5tytijwvcflpwhnao77ffijjncgq |
| Canonical-Ubuntu-24.04-Minimal-aarch64-2025.05.20-0   | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaa6y7yd2njc7ezdngpeippyod2ncrfajgpglikjs5r6vgm3qoobua |
| Canonical-Ubuntu-22.04-aarch64-2025.09.26-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaflw32yjwdkwmqxic5mn4z5iriv4kgdadjqwmotx5z67tm2wzcwaa |
| Canonical-Ubuntu-22.04-aarch64-2025.07.24-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaww5bbjvzql4bvtt3nrok7v2k6atg55ldvgffg36jqdd4wc7ecssa |
| Canonical-Ubuntu-22.04-aarch64-2025.05.20-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaatexnxf5zopnp2xlaya6e4twunsfuupi3rfhuh2jtjzrax5q5bwuq |
| Canonical-Ubuntu-22.04-Minimal-aarch64-2025.09.22-0   | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaakmukoot6oky72sq5mkzzwom423ycrkkchl6tudoj5vv5cae3mbba |
| Canonical-Ubuntu-22.04-Minimal-aarch64-2025.07.23-0   | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4y4ibex6wtagiokpbyqin6kied6uuviqcn35cevhc7r6263wjboa |
| Canonical-Ubuntu-22.04-Minimal-aarch64-2025.05.20-0   | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaap6feqvhc25exuerg6ti5gc3y6g47xrjss7zgwtrt3xg42gw7t4pq |
| Canonical-Ubuntu-20.04-aarch64-2025.07.23-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaafmmsrqjzb6dql6i6by4ddi4ughbvir5gbrhbkfsdpdmie5i27tka |
| Canonical-Ubuntu-20.04-aarch64-2025.05.20-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa6onfuzoz3tic3jlebkm5ekfq3x2pmudw6oojirwucpxxcd7o7qpa |
| Canonical-Ubuntu-20.04-aarch64-2025.03.28-0           | ocid1.image.oc1.eu-frankfurt-1.aaaaaaaahxy64vzstrzpcr6aehqucw3354fxmokipfxm53gnngofzjscp2ia |
```

## How to do this in ansible 

https://docs.ansible.com/ansible/2.8/user_guide/playbooks_best_practices.html#directory-layout


Can depend on one resource, ie DBS 

https://blogs.oracle.com/cloudmarketplace/post/explore-ansible-within-oracle-resource-manager-host-to-configure-oci-resources

https://github.com/oracle-quickstart/oci-crowdstrike/tree/main/sample-ansible

Then execute like so, 

```hcl

resource "null_resource" "install_app_httpd" {
  depends_on = [oci_core_instance.instace_app, ]

  provisioner "local-exec" {
    command = "chmod 400 ${local_file.private_key_file.filename}"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '${oci_core_instance.instance_db.0.private_ip},' ${var.playbook_path}"
  }
}
```

For example: 
```
export ANSIBLE_HOST_KEY_CHECKING=False 

ansible-playbook -i localhost:9008 

```

## Manual


Upgrade os (ol) 
```
sudo yum update -y
```

```
sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens3
  sources:
  services: dhcpv6-client ssh
  ports:
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
```

```
sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp

sudo firewall-cmd --list-all
<<
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens3
  sources:
  services: dhcpv6-client ssh
  ports: 3306/tcp
  protocols:
  forward: no
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
```

download and apply rpm source for mysql
```
sudo yum install ./mysql80-community-release-el8-5.noarch.rpm

sudo yum update -y
```

make sure no mariadb stuff present!
```
sudo yum list installed | grep -i -e maria
```
install
```
sudo yum install mysql-server -y 
```

start
```
sudo service mysqld enable
sudo service mysqld start

sudo service mysqld status
<<
● mysqld.service - MySQL 8.0 database server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; disabled; vendor preset: disabled)
   Active: active (running) since Tue 2023-06-27 11:48:05 GMT; 48s ago
  Process: 197011 ExecStartPost=/usr/libexec/mysql-check-upgrade (code=exited, status=0/SUCCESS)
  Process: 196886 ExecStartPre=/usr/libexec/mysql-prepare-db-dir mysqld.service (code=exited, status=0/SUCCESS)
  Process: 196861 ExecStartPre=/usr/libexec/mysql-check-socket (code=exited, status=0/SUCCESS)
 Main PID: 196965 (mysqld)
   Status: "Server is operational"
    Tasks: 39 (limit: 99872)
   Memory: 452.7M
   CGroup: /system.slice/mysqld.service
           └─196965 /usr/libexec/mysqld --basedir=/usr

Jun 27 11:47:59 mysql-test systemd[1]: Starting MySQL 8.0 database server...
Jun 27 11:48:00 mysql-test mysql-prepare-db-dir[196886]: Initializing MySQL database
Jun 27 11:48:05 mysql-test systemd[1]: Started MySQL 8.0 database server.

```

secure config
```
which mysql_secure_installation
<<
/usr/bin/mysql_secure_installation


sudo mysql_secure_installation
<<
Securing the MySQL server deployment.

Connecting to MySQL using a blank password.

VALIDATE PASSWORD COMPONENT can be used to test passwords
and improve security. It checks the strength of password
and allows the users to set only those passwords which are
secure enough. Would you like to setup VALIDATE PASSWORD component?

Press y|Y for Yes, any other key for No: Y

There are three levels of password validation policy:

LOW    Length >= 8
MEDIUM Length >= 8, numeric, mixed case, and special characters
STRONG Length >= 8, numeric, mixed case, special characters and dictionary                  file

Please enter 0 = LOW, 1 = MEDIUM and 2 = STRONG: 2
Please set the password for root here.

New password:

Re-enter new password:

Estimated strength of the password: 100
Do you wish to continue with the password provided?(Press y|Y for Yes, any other key for No) : Y
By default, a MySQL installation has an anonymous user,
allowing anyone to log into MySQL without having to have
a user account created for them. This is intended only for
testing, and to make the installation go a bit smoother.
You should remove them before moving into a production
environment.

Remove anonymous users? (Press y|Y for Yes, any other key for No) : Y
Success.


Normally, root should only be allowed to connect from
'localhost'. This ensures that someone cannot guess at
the root password from the network.

Disallow root login remotely? (Press y|Y for Yes, any other key for No) : Y
Success.

By default, MySQL comes with a database named 'test' that
anyone can access. This is also intended only for testing,
and should be removed before moving into a production
environment.


Remove test database and access to it? (Press y|Y for Yes, any other key for No) : Y
 - Dropping test database...
Success.

 - Removing privileges on test database...
Success.

Reloading the privilege tables will ensure that all changes
made so far will take effect immediately.

Reload privilege tables now? (Press y|Y for Yes, any other key for No) : Y
Success.

All done!
```

Validate
```
mysql -u root -p
<<
Enter password:

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 10
Server version: 8.0.32 Source distribution

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.00 sec)

```

Finally, validate from client after opening up a local port that points to node: 
```
mysqlsh --mysql -u root -p
Please provide the password for 'root@localhost': ************************************
Save password for 'root@localhost'? [Y]es/[N]o/Ne[v]er (default No): no
MySQL Shell 8.0.31

Copyright (c) 2016, 2022, Oracle and/or its affiliates.
Oracle is a registered trademark of Oracle Corporation and/or its affiliates.
Other names may be trademarks of their respective owners.

Type '\help' or '\?' for help; '\quit' to exit.
Creating a Classic session to 'root@localhost'
Fetching schema names for auto-completion... Press ^C to stop.
Your MySQL connection id is 11
Server version: 8.0.32 Source distribution
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306 ssl  JS > \sql
Switching to SQL mode... Commands end with ;
Fetching global names for auto-completion... Press ^C to stop.
 MySQL  localhost:3306 ssl  SQL > show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.0129 sec)
 MySQL  localhost:3306 ssl  SQL > \exit
Bye!
```


Create mysql user for remote connection 
```sql
create user 'admin'@'%'
  identified by 'new password' 
;

grant all privileges on *.* to 'admin'@'%';

flush privileges; 
```


