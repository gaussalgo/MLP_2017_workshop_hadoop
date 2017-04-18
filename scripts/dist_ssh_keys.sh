#!/bin/bash

# hostname / IP list
utility_host="138.68.70.181"
eth0_hosts="138.68.70.181 207.154.195.117 138.68.74.49 138.68.64.179 207.154.212.76 207.154.217.153"

# create simple ssh key pair on the remote utility node
ssh -i do-key root@${utility_host} 'ssh-keygen -t rsa -C "cloudera_key" -N "" -f .ssh/id_rsa'
echo "key pair created on ${utility_host}"

# download keys to local laptop
scp -i do-key -C root@${utility_host}:~/.ssh/id_rsa* .
echo "generated keys downloaded"

# enable public key access for nodes in the list
for server in $eth0_hosts; do
  scp -i do-key -C id_rsa* root@${server}:~/.ssh/
  cat id_rsa.pub | ssh -i do-key root@${server} 'cat >> ~/.ssh/authorized_keys'
done
echo "public key access enabled between hosts"
