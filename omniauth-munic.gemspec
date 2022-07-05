# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-munic/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-munic'
  spec.version       = OmniAuth::Munic::VERSION

  spec.description   = 'Munic.io OAuth2 strategy for OmniAuth.'
  spec.summary       = spec.description

  spec.authors       = ['maxime dufay']
  spec.email         = ['maxime.dufay@mobile-devices.fr']
  spec.homepage      = 'https://github.com/municio/omniauth-munic'
  spec.license       = 'MIT'

  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.7', '>= 1.7.0'

  spec.add_development_dependency 'rake', '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.8', '>= 3.8.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
