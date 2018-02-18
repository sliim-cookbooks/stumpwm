# -*- coding: utf-8 -*-
#
# Cookbook Name:: stumpwm
# Attributes:: default
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

default['stumpwm']['build_dir'] = '/opt/stumpwm'
default['stumpwm']['quicklisp_dir'] = '/opt/quicklisp'
default['stumpwm']['repository'] = 'https://github.com/stumpwm/stumpwm.git'
default['stumpwm']['version'] = '1.0.0'
default['stumpwm']['user'] = 'root'
default['stumpwm']['packages'] = []

case node['platform']
when 'debian'
  default['stumpwm']['packages'] = %w(sbcl xorg autoconf texinfo install-info cl-asdf cl-clx-sbcl cl-ppcre)
end
