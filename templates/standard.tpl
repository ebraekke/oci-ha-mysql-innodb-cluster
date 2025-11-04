#cloud-config

package_upgrade: true

packages:

runcmd:
  - /usr/bin/timedatectl set-timezone Europe/Oslo
  