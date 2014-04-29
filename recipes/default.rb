# encoding: utf-8
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

include_recipe 'apt'

node['stumpwm']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

remote_file Chef::Config[:file_cache_path] + '/ql.lisp' do
  source 'http://beta.quicklisp.org/quicklisp.lisp'
  mode 644
end

cookbook_file Chef::Config[:file_cache_path] + '/sbcl.init' do
  source 'sbcl.init'
end

unless Dir.exist? '/opt/quicklisp'
  execute 'init sbcl' do
    cwd Chef::Config[:file_cache_path]
    command 'echo | sbcl --load ql.lisp --script sbcl.init'
  end
end

remotefile = 'https://github.com/stumpwm/stumpwm/archive/'
remotefile << node['stumpwm']['version'] << '.tar.gz'
localfile = Chef::Config[:file_cache_path] + '/stumpwm.tar.gz'

remote_file localfile do
  source remotefile
  mode '0644'
end

directory node['stumpwm']['build_dir'] do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  recursive true
end

execute 'untar' do
  cwd node['stumpwm']['build_dir']
  command 'tar --strip-components 1 -xzf ' + localfile
end

execute 'configure and make' do
  cwd node['stumpwm']['build_dir']
  command 'autoconf; ./configure; make'
end

execute 'Install stumpwm' do
  cwd node['stumpwm']['build_dir']
  command 'make install'
end