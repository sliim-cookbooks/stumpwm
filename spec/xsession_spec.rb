# -*- coding: utf-8 -*-
#
# Cookbook Name:: stumpwm
# Spec:: xsession
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

describe 'stumpwm::xsession' do
  subject { ChefSpec::Runner.new.converge(described_recipe) }

  it 'does create xsessions directory' do
    expect(subject).to create_directory('/usr/share/xsessions')
      .with(owner: 'root',
            group: 'root',
            mode: '0755')
  end

  it 'does create xsession desktop file for stumpwm' do
    # rubocop:disable Metrics/LineLength
    expect(subject).to create_cookbook_file('/usr/share/xsessions/stumpwm.desktop')
      .with(source: 'stumpwm.desktop')
  end
end
