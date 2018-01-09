# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'stumpwm::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache',
                             platform: 'debian',
                             version: '9.0') do |node|
      node.override['stumpwm']['build_dir'] = '/opt/stumpwm-build'
      node.override['stumpwm']['quicklisp_dir'] = '/opt/ql-build'
      node.override['stumpwm']['version'] = '6.6.6'
      node.override['stumpwm']['packages'] = ['emacs']
    end.converge described_recipe
  end

  it 'includes recipe[apt]' do
    expect(subject).to include_recipe('apt')
  end

  it 'includes recipe[build-essential]' do
    expect(subject).to include_recipe('build-essential')
  end

  it 'installs package[emacs]' do
    expect(subject).to install_package('emacs')
  end

  it 'creates remote_file[/var/chef/cache/ql.lisp]' do
    expect(subject).to create_remote_file('/var/chef/cache/ql.lisp')
      .with(source: 'http://beta.quicklisp.org/quicklisp.lisp',
            mode: '0644')
  end

  it 'creates template[/var/chef/cache/sbcl.init]' do
    expect(subject).to create_template('/var/chef/cache/sbcl.init')
      .with(source: 'sbcl.init.erb',
            mode: '0644')

    expect(subject).to render_file('/var/chef/cache/sbcl.init')
      .with_content(%r{\(quicklisp-quickstart:install :path "/opt/ql-build"\)})
  end

  it 'runs execute[install quicklisp]' do
    expect(subject).to run_execute('install quicklisp')
      .with(cwd: '/var/chef/cache',
            command: 'echo | sbcl --load ql.lisp --script sbcl.init')
  end

  it 'creates remote_file[/var/chef/cache/stumpwm.tar.gz]' do
    expect(subject).to create_remote_file('/var/chef/cache/stumpwm.tar.gz')
      .with(source: 'https://github.com/stumpwm/stumpwm/archive/6.6.6.tar.gz',
            mode: '0644')
  end

  it 'creates directory[/opt/stumpwm-build]' do
    expect(subject).to create_directory('/opt/stumpwm-build')
      .with(mode: '0755',
            recursive: true)
  end

  it 'runs execute[untar]' do
    expect(subject).to run_execute('untar')
      .with(cwd: '/opt/stumpwm-build',
            command: format('%s %s %s',
                            'tar',
                            '--strip-components 1 -xzf',
                            '/var/chef/cache/stumpwm.tar.gz'))
  end

  it 'runs execute[configure and make]' do
    expect(subject).to run_execute('configure and make')
      .with(cwd: '/opt/stumpwm-build',
            command: 'autoconf && ./configure && make')
  end

  it 'runs execute[install stumpwm]' do
    expect(subject).to run_execute('install stumpwm')
      .with(cwd: '/opt/stumpwm-build',
            command: 'make install')
  end
end
