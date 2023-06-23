#cloud-config

package_upgrade: true

packages:
  - python
  - python3

runcmd:
  - /usr/bin/timedatectl set-timezone Europe/Oslo
