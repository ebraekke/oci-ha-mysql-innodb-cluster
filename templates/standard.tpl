#cloud-config

package_upgrade: false

packages:
  - python
  - python3

runcmd:
  - /usr/bin/timedatectl set-timezone Europe/Oslo
  