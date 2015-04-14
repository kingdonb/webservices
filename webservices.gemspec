# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webservices/version'

Gem::Specification.new do |spec|
  spec.name          = "Webservices"
  spec.version       = Webservices::VERSION
  spec.authors       = ["Richard de los Santos"]
  spec.email         = ["rdelossa@nd.edu"]
  spec.summary       = "Provide webservices to apps"
  spec.description   = "This gem provides webservices to other apps"
  spec.homepage      = "http://registrar.nd.edu"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency '3scale_client'
end
