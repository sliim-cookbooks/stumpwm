stumpwm Cookbook
================
Download and install The Stump Window Manager.  
[![Cookbook Version](https://img.shields.io/cookbook/v/stumpwm.svg)](https://community.opscode.com/cookbooks/stumpwm) [![Build Status](https://travis-ci.org/sliim-cookbooks/stumpwm.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/stumpwm) 

Requirements
------------
#### Cookbooks
- `build-essential` - `https://supermarket.getchef.com/cookbooks/build-essential`

#### Platforms
The following platforms and versions are tested and supported using Opscode's test-kitchen.
- Debian 8
- Debian 9

Attributes
----------
#### stumwm::default
|  Key                       |  Type  |  Description                                                                  |
| -------------------------- | ------ | ----------------------------------------------------------------------------- |
| `[stumpwm][user]`          | String | User used to build stumpwm project (default: `root`)                          |
| `[stumpwm][build_dir]`     | String | Where stumpwm archive will be extracted and builded (default: `/opt/stumpwm`) |
| `[stumpwm][quicklisp_dir]` | String | Where quicklisp will be installed (default: `/opt/quicklisp`)                 |
| `[stumpwm][repository]`    | String | Stumpwm git repository (default: `https://github.com/stumpwm/stumpwm.git`)    |
| `[stumpwm][version]`       | String | Stumpwm version to install (default: `1.0.0`)                                 |
| `[stumpwm][packages]`      | Array  | Packages to install, depends of the platform (default: `[]`)                  |

Usage
-----
#### stumpwm::default
Just include `stumpwm` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[stumpwm]"
  ]
}
```

#### stumpwm::xsession
You can also use `stumpwm::xsession` to install xsession file for login managers (GDM, Slim etc..)

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[stumpwm]"
    "recipe[stumpwm::xsession]"
  ]
}
```

#### Tests

- First, install dependencies:  
`bundle install`

- Run Checkstyle and ChefSpec:  
`bundle exec rake`

- Run Kitchen tests:  
`bundle exec rake kitchen`  

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
