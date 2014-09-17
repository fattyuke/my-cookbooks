#
# Cookbook Name:: hosts
# Recipe:: default
#
# Copyright 2014, Andy Ryan 
#
# All rights reserved - Do Not Redistribute
#
# Gets list of names from all nodes in repository and rewrites /etc/hosts
hosts = {}
localhost = nil

search(:node, "name:*", %w(ipaddress fqdn)) do |n|
 hosts[n["ipaddress"]] = n
end

template "/etc/hosts" do
 source "hosts.erb"
 mode 0644
 variables(:hosts => hosts)
end
