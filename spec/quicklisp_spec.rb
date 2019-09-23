# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'stumpwm::quicklisp' do
  let(:subject) do
    ChefSpec::SoloRunner.new do |node|
      node.override['stumpwm']['quicklisp_dir'] = '/opt/ql-build'
      node.override['stumpwm']['user'] = 'builduser'
    end.converge described_recipe
  end

  before do
    stub_command('test -f /opt/ql-build/ql.lisp').and_return(false)
  end

  it 'creates directory[/opt/ql-build]' do
    expect(subject).to create_directory('/opt/ql-build')
      .with(mode: '0755',
            recursive: true,
            owner: 'builduser')
  end

  it 'creates directory[/opt/ql-build/common-lisp/builduser]' do
    expect(subject).to create_directory('/opt/ql-build/common-lisp/builduser')
      .with(mode: '0755',
            recursive: true,
            owner: 'builduser')
  end

  it 'creates remote_file[/opt/ql-build/ql.lisp]' do
    expect(subject).to create_remote_file('/opt/ql-build/ql.lisp')
      .with(source: 'https://beta.quicklisp.org/quicklisp.lisp',
            mode: '0644')
  end

  it 'creates template[/opt/ql-build/sbcl.init]' do
    expect(subject).to create_template('/opt/ql-build/sbcl.init')
      .with(source: 'sbcl.init.erb',
            mode: '0644')

    expect(subject).to render_file('/opt/ql-build/sbcl.init')
      .with_content(%r{\(quicklisp-quickstart:install :path "/opt/ql-build"\)})
  end
end
