# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'stumpwm::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['stumpwm']['build_dir'] = '/opt/stumpwm-build'
      node.override['stumpwm']['quicklisp']['install_dir'] = '/opt/ql-build'
      node.override['stumpwm']['version'] = '6.6.6'
      node.override['stumpwm']['packages'] = ['emacs']
      node.override['stumpwm']['user'] = 'builduser'
    end.converge described_recipe
  end

  before do
    stub_command('test -f /opt/ql-build/ql.lisp').and_return(false)
  end

  it 'installs package[emacs]' do
    expect(subject).to install_package('emacs')
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
