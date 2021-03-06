# Cookbook:: stumpwm
# Recipe:: quicklisp
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

execute 'install-quicklisp' do
  command "su - #{node['stumpwm']['user']} -c 'echo |sbcl "\
          "--load #{node['stumpwm']['quicklisp']['install_dir']}/ql.lisp "\
          "--script #{node['stumpwm']['quicklisp']['install_dir']}/sbcl.init'"
  action :nothing
end

quicklisp_dir = node['stumpwm']['quicklisp']['install_dir']
[quicklisp_dir, "#{quicklisp_dir}/common-lisp/#{node['stumpwm']['user']}"].each do |dir|
  directory dir do
    owner node['stumpwm']['user']
    recursive true
    mode '0755'
  end
end

remote_file "#{node['stumpwm']['quicklisp']['install_dir']}/ql.lisp" do
  source 'https://beta.quicklisp.org/quicklisp.lisp'
  mode '0644'
  not_if "test -f #{node['stumpwm']['quicklisp']['install_dir']}/ql.lisp"
end

template "#{node['stumpwm']['quicklisp']['install_dir']}/sbcl.init" do
  source 'sbcl.init.erb'
  mode '0644'
  variables qldir: node['stumpwm']['quicklisp']['install_dir'],
            loads: node['stumpwm']['quicklisp']['loads']
  notifies :run, 'execute[install-quicklisp]', :immediately
end
