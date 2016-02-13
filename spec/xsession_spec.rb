# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'stumpwm::xsession' do
  subject { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates directory[/usr/share/xsessions]' do
    expect(subject).to create_directory('/usr/share/xsessions')
      .with(owner: 'root',
            group: 'root',
            mode: '0755')
  end

  it 'creates cookbook_file[/usr/share/xsessions/stumpwm.desktop]' do
    expect(subject).to create_cookbook_file(
      '/usr/share/xsessions/stumpwm.desktop'
    ).with(source: 'stumpwm.desktop')
  end
end
