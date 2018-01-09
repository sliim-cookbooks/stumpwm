# -*- coding: utf-8 -*-
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

name             'stumpwm'
maintainer       'Sliim'
maintainer_email 'sliim@mailoo.org'
license          'Apache-2.0'
description      'Installs/Configures Stumpwm'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 12.5' if respond_to?(:chef_version)
version          '0.2.0'

recipe 'default', 'Install and configure StumpWM'
recipe 'xsession', 'Create xsession desktop file'

%w(apt build-essential).each do |cb|
  depends cb
end

supports 'debian'

source_url 'https://github.com/sliim-cookbooks/stumpwm' if
  respond_to?(:source_url)
issues_url 'https://github.com/sliim-cookbooks/stumpwm/issues' if
  respond_to?(:issues_url)
