# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pivotal_tracker_api/version'

Gem::Specification.new do |spec|
  spec.name          = "pivotal_tracker_api"
  spec.version       = PivotalTrackerApi::VERSION
  spec.authors       = ["Fabien Garcia"]
  spec.email         = ["fab0670312047@gmail.com"]
  spec.summary       = "Ruby wrapper for the Pivotal Tracker API"
  spec.description   = "Ruby wrapper for the Pivotal Tracker API based on V5"
  spec.homepage      = "https://github.com/testCloud"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", ">= 0"
  spec.add_runtime_dependency "rest-client", ">= 1.6.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "webmock"
  spec.add_dependency "multipart-post"
end
