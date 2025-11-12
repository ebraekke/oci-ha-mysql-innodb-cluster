#cloud-config
# this is specifically for Ubuntu 
package_upgrade: false

users:
  - name: ${jump_user}    
    shell: /bin/false
    ssh-authorized-keys:
      - ${jump_key}

runcmd:
  - [touch, /tmp/cloud-init-begin]
  - [sed, -i,'s/PermitRootLogin.*/PermitRootLogin no/g',/etc/ssh/sshd_config]
  - [userdel, -f, -r, ${super_user}]
  - [systemctl, restart, ssh]
  - [touch, /tmp/cloud-init-done]