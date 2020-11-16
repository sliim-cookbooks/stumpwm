require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.log_level = :error
  config.platform = 'debian'
  config.version = '9.9'
end

ChefSpec::Coverage.start! { add_filter 'stumpwm' }

require 'chef/application'
