Host *
  IgnoreUnknown UseKeychain
  StrictHostKeyChecking no
  AddKeysToAgent no
  UseKeychain no
  IdentityFile ${private_key_path}
  UserKnownHostsFile=/dev/null

Host ${destination_private_ip}
  User ${destination_ssh_user}
  HostName ${destination_private_ip}
  Port 22
  