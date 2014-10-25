# -*- coding: utf-8 -*-
#
# Cookbook Name:: stumpwm
# Spec:: default
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

require_relative 'spec_helper'

describe 'stumpwm::default' do
  let(:subject) do
    ChefSpec::Runner.new do |node|
      node.set['stumpwm']['build_dir'] = '/opt/stumpwm-build'
      node.set['stumpwm']['quicklisp_dir'] = '/opt/ql-build'
      node.set['stumpwm']['version'] = '6.6.6'
      node.set['stumpwm']['packages'] = ['emacs']
    end.converge described_recipe
  end

  it 'does include apt recipe' do
    expect(subject).to include_recipe('apt')
  end

  it 'does include build-essential recipe' do
    expect(subject).to include_recipe('build-essential')
  end

  it 'does install emacs package' do
    expect(subject).to install_package('emacs')
  end

  it 'does download quicklisp setup script' do
    expect(subject).to create_remote_file('/var/chef/cache/ql.lisp')
      .with(source: 'http://beta.quicklisp.org/quicklisp.lisp',
            mode: '0644')
  end

  it 'does create sbcl init file' do
    expect(subject).to create_template('/var/chef/cache/sbcl.init')
      .with(source: 'sbcl.init.erb',
            mode: '0644')

    expect(subject).to render_file('/var/chef/cache/sbcl.init')
      .with_content(%r{\(quicklisp-quickstart:install :path "/opt/ql-build"\)})
  end

  it 'it does install quicklisp' do
    expect(subject).to run_execute('install quicklisp')
      .with(cwd: '/var/chef/cache',
            command: 'echo | sbcl --load ql.lisp --script sbcl.init')
  end

  it 'does download stumpwm package' do
    expect(subject).to create_remote_file('/var/chef/cache/stumpwm.tar.gz')
      .with(source: 'https://github.com/stumpwm/stumpwm/archive/6.6.6.tar.gz',
            mode: '0644')
  end

  it 'does create build directory for stumpwm' do
    expect(subject).to create_directory('/opt/stumpwm-build')
      .with(mode: '0755',
            recursive: true)
  end

  it 'does untar stumpwm package' do
    expect(subject).to run_execute('untar')
      .with(cwd: '/opt/stumpwm-build',
            command: format('%s %s %s',
                            'tar',
                            '--strip-components 1 -xzf',
                            '/var/chef/cache/stumpwm.tar.gz'))
  end

  it 'does configure and build stumpwm' do
    expect(subject).to run_execute('configure and make')
      .with(cwd: '/opt/stumpwm-build',
            command: 'autoconf && ./configure && make')
  end

  it 'does install stumpwm' do
    expect(subject).to run_execute('install stumpwm')
      .with(cwd: '/opt/stumpwm-build',
            command: 'make install')
  end
end
