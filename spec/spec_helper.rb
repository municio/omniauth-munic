require 'bundler/setup'
Bundler.setup

require 'omniauth-munic'

RSpec.configure do |config|
  config.extend(OmniAuth::Test::StrategyMacros, type: :strategy)
end
