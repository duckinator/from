# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'from/version'

Gem::Specification.new do |spec|
  spec.name          = "from"
  spec.version       = From::VERSION
  spec.authors       = ["Ellen Marie Dash"]
  spec.email         = ["me@duckie.co"]

  spec.summary       = "ES6-inspired from/import support, for Ruby."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/duckinator/from"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Ruby 2.5+ are still maintained. https://www.ruby-lang.org/en/downloads/branches/
  # From uses Binding#receiver, which requires Ruby 2.2.0 or newer.
  spec.required_ruby_version = ">= 2.2.0"

  spec.add_runtime_dependency "debug_inspector"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec"
end
