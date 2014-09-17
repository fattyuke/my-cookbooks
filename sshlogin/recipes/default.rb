#
# Cookbook Name:: sshlogin
# Recipe:: default
#
# Copyright 2014, Andy Ryan 
#
# All rights reserved - Do Not Redistribute
#
# Create empty RSA password
execute "ssh-keygen" do
  command "sudo -u hadoop ssh-keygen -q -t rsa -N '' -f /home/hadoop/.ssh/id_rsa"
  creates "/home/hadoop/.ssh/id_rsa"
  action :run
end

# Copy public key to node1; if key doesn't exist in authorized_keys, append it to this file
execute <<EOF
cat /home/hadoop/.ssh/id_rsa.pub | sudo -u hadoop ssh hadoop@node1 "(cat > /tmp/tmp.pubkey; mkdir -p .ssh; touch .ssh/authorized_keys; grep #{node[:fqdn]} .ssh/authorized_keys > /dev/null || cat /tmp/tmp.pubkey >> .ssh/authorized_keys; rm /tmp/tmp.pubkey)"
EOF
