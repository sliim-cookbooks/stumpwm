stumpwm CHANGELOG
=================

This file is used to list changes made in each version of the stumpwm cookbook.

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

