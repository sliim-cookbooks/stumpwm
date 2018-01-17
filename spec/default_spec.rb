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
      node.override['stumpwm']['user'] = 'builduser'
    end.converge described_recipe
  end

  before do
    stub_command('test -f /var/chef/cache/ql.lisp').and_return(false)
  end

  it 'includes recipe[build-essential]' do
    expect(subject).to include_recipe('build-essential')
  end

  it 'installs package[emacs]' do
    expect(subject).to install_package('emacs')
  end

  it 'includes recipe[stumpwm::quicklisp]' do
    expect(subject).to include_recipe('build-essential')
  end

  it 'creates directory[/opt/stumpwm-build]' do
    expect(subject).to create_directory('/opt/stumpwm-build')
      .with(mode: '0755',
            recursive: true,
            owner: 'builduser')
  end

  it 'syncs git[/opt/stumpwm-build]' do
    expect(subject).to sync_git('/opt/stumpwm-build')
      .with(repository: 'https://github.com/stumpwm/stumpwm.git',
            reference: '6.6.6',
            user: 'builduser')
  end
end
