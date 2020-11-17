stumpwm CHANGELOG
=================

This file is used to list changes made in each version of the stumpwm cookbook.

0.6.1
-----
- Run make command in a login shell when building stumpwm

0.6.0
-----
- Set `quicklisp` configuration in `node[stumpwm][quicklisp]` attributes
- **BREAKING CHANGE**: Attribute `node[stumpwm][quicklisp_dir]` moved to `node[stumpwm][quicklisp][install_dir]`
- Added `node[stumpwm][quicklisp][loads]` attribute to set packages to load in sbcl init
- Improved stumpwm build commands

0.5.0
-----
- Added support for Ubuntu 18.04

0.4.0
-----
- Added stumpwm::quicklisp recipe and improved quicklisp install
- Fixed XDG_CACHE_HOME envvar when building stumpwm
- Added common lisp packages to packages list to install in default attributes

0.3.0
-----
- Removed `apt` cookbook dependency
- Download quicklisp over https
- Build StumpWM from git repository

0.2.0
-----
- Code cleanup
  - Removed Strainer, use Rake instead
  - No integration testing for travis
  - Improve README
- Support debian jessie
- Add packages to default installed for debian:
  - texinfo
  - install-info

0.1.3
-----
- Fixed idempotence issue
- build-essential cookbook is now a dependency

0.1.2
-----
- Fixed compilation error
- Added ChefSpec
- Code improvements

0.1.1
-----
- Use official opscode box for test-kitchen

0.1.0
-----
- Initial release of stumpwm

