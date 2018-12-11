#
# Cookbook:: base
# Recipe:: default
#
# Copyright:: 2018,  Larry Charbonneau
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

user node['lc4_base']['username'] do
  manage_home true
  comment 'Admin User'
  uid node['lc4_base']['gid']
  home node['lc4_base']['home_dir']
  shell '/bin/bash'
  password node['lc4_base']['password']
end

group 'wheel' do
  members node['lc4_base']['username']
  append true
  action :modify
end

directory "#{node['lc4_base']['home_dir']}/.ssh" do
  owner node['lc4_base']['username']
  group node['lc4_base']['group']
  mode '0700'
  recursive true
  action :create
end

template "#{node['lc4_base']['home_dir']}/.ssh/authorized_keys" do
  source 'authorized_keys.erb'
  owner node['lc4_base']['username']
  group node['lc4_base']['group']
  mode '0700'
  action :create
end

template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  owner 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[sshd]'
end

service 'sshd' do
  action :nothing
end
