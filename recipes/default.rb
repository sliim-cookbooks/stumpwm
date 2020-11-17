# Cookbook:: stumpwm
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

build_essential 'stumpwm'

node['stumpwm']['packages'].each do |pkg|
  package pkg
end

include_recipe 'stumpwm::quicklisp'

buildenv = {
  SBCL_HOME: '/usr/lib/sbcl',
  XDG_CACHE_HOME: "#{node['stumpwm']['quicklisp']['install_dir']}/common-lisp/#{node['stumpwm']['user']}"
}

execute 'configure' do
  cwd node['stumpwm']['build_dir']
  command './autogen.sh && ./configure'
  environment buildenv
  user node['stumpwm']['user']
  action :nothing
end

bash 'make' do
  cwd node['stumpwm']['build_dir']
  code 'make'
  environment buildenv
  user node['stumpwm']['user']
  action :nothing
end

execute 'install' do
  cwd node['stumpwm']['build_dir']
  command 'make install'
  user 'root'
  action :nothing
end

directory node['stumpwm']['build_dir'] do
  owner node['stumpwm']['user']
  recursive true
  mode '0755'
end

git node['stumpwm']['build_dir'] do
  user node['stumpwm']['user']
  repository node['stumpwm']['repository']
  reference node['stumpwm']['version']
  notifies :run, 'execute[configure]', :immediately
  notifies :run, 'bash[make]', :immediately
  notifies :run, 'execute[install]', :immediately
  action :sync
end
