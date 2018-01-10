# -*- coding: utf-8 -*-
#
# Cookbook Name:: stumpwm
# Recipe:: default
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'build-essential'

node['stumpwm']['packages'].each do |pkg|
  package pkg
end

execute 'install-quicklisp' do
  command "su - #{node['stumpwm']['user']} -c 'echo |sbcl "\
          "--load #{Chef::Config[:file_cache_path]}/ql.lisp "\
          "--script #{Chef::Config[:file_cache_path]}/sbcl.init'"
  action :nothing
end

execute 'configure-make' do
  cwd node['stumpwm']['build_dir']
  command 'autoconf && ./configure && make'
  environment SBCL_HOME: '/usr/lib/sbcl',
              XDG_CACHE_HOME: "#{Chef::Config[:file_cache_path]}/common-lisp/#{node['stumpwm']['user']}"
  user node['stumpwm']['user']
  action :nothing
end

execute 'make-install' do
  cwd node['stumpwm']['build_dir']
  command 'make install'
  user 'root'
  action :nothing
end

[node['stumpwm']['build_dir'],
 node['stumpwm']['quicklisp_dir'],
 "#{Chef::Config[:file_cache_path]}/common-lisp/#{node['stumpwm']['user']}"].each do |dir|
  directory dir do
    owner node['stumpwm']['user']
    recursive true
    mode '0755'
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/ql.lisp" do
  source 'https://beta.quicklisp.org/quicklisp.lisp'
  mode '0644'
end

template "#{Chef::Config[:file_cache_path]}/sbcl.init" do
  source 'sbcl.init.erb'
  mode '0644'
  variables qldir: node['stumpwm']['quicklisp_dir']
  notifies :run, 'execute[install-quicklisp]', :immediately
end

git node['stumpwm']['build_dir'] do
  user node['stumpwm']['user']
  repository node['stumpwm']['repository']
  reference node['stumpwm']['version']
  notifies :run, 'execute[configure-make]', :immediately
  notifies :run, 'execute[make-install]', :immediately
  action :sync
end
