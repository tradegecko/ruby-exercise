# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ejaydj/version'

Gem::Specification.new do |spec|
  spec.name          = "ejaydj"
  spec.version       = Ejaydj::VERSION
  spec.authors       = ["Ejay Canaria"]
  spec.email         = ["ejaypcanaria@gmail.com"]
  spec.summary       = %q{A bot that tweets a song based on your spotify playlists}
  spec.description   = %q{A bot that tweets a song based on your spotify playlists}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client", "~> 1.7"
  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "twitter"
  spec.add_runtime_dependency "googl"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

end
