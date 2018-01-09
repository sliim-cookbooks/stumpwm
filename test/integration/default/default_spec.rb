# -*- coding: utf-8 -*-

describe file('/opt/stumpwm') do
  it { should be_directory }
  it { should be_mode 755 }
end

describe file('/opt/quicklisp') do
  it { should be_directory }
end

describe file('/opt/quicklisp/setup.lisp') do
  it { should be_file }
end

describe file('/usr/local/bin/stumpwm') do
  it { should be_file }
  it { should be_executable }
end
