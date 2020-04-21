# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'from/version'

Gem::Specification.new do |spec|
  spec.name          = "from"
  spec.version       = From::VERSION
  spec.authors       = ["Ellen Marie Dash"]
  spec.email         = ["me@duckie.co"]

  spec.summary       = "Python-style from/import support, for Ruby."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/ruby-heresy/from"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # From uses Binding#receiver, which requires Ruby 2.2.0 or newer.
  spec.required_ruby_version = ">= 2.2.0"

  spec.add_runtime_dependency "wot-utilities", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec"
end
