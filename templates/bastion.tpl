#cloud-config

package_upgrade: true

packages:
  - python
  - python3

users:
  # Works on Ubuntu 18.04 and higher
  # User is *not* sudo even if the banner is displayed 
  - name: jump    
    ssh-authorized-keys:
%{ for jump_key in ssh_jump_keys ~}      
    - ${jump_key}
%{ endfor ~}   
    shell: /bin/false

runcmd:
  - /usr/bin/timedatectl set-timezone Europe/Oslo
  - /sbin/userdel -f -r ${super_user}
