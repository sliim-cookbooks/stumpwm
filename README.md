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
- Ubuntu 18.04

Attributes
----------
#### stumwm::default
| Key                                 | Type   | Description                                                                                  |
| --------------------------          | ------ | -------------------------------------------------------------------------------------------- |
| `[stumpwm][user]`                   | String | User used to build stumpwm project (default: `root`)                                         |
| `[stumpwm][build_dir]`              | String | Where stumpwm archive will be extracted and builded (default: `/opt/stumpwm`)                |
| `[stumpwm][repository]`             | String | Stumpwm git repository (default: `https://github.com/stumpwm/stumpwm.git`)                   |
| `[stumpwm][version]`                | String | Stumpwm version to install (default: `1.0.0`)                                                |
| `[stumpwm][packages]`               | Array  | Packages to install, depends of the platform (default: `[]`)                                 |
| `[stumpwm][quicklisp][install_dir]` | String | Where quicklisp will be installed (default: `/opt/quicklisp`)                                |
| `[stumpwm][quicklisp][loads]`       | Array  | List of packages to load when initializing sbcl (default: `[clx, cl-ppcre, alexandria`) |

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

#### stumpwm::quicklisp
Just include `stumpwm::quicklisp` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[stumpwm::quicklisp]"
  ]
}
```

Note: This recipe is already included by `stumpwm::default`.

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

Testing
-------
See [TESTING.md](TESTING.md)

Contributing
------------
See [CONTRIBUTING.md](CONTRIBUTING.md)

License and Authors
-------------------
Authors: Sliim <sliim@mailoo.org> 

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
