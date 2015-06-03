# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'from/version'

Gem::Specification.new do |spec|
  spec.name          = "from"
  spec.version       = From::VERSION
  spec.authors       = ["Marie Markwell"]
  spec.email         = ["me@marie.so"]

  spec.summary       = "Python-style from/import support, for Ruby."
  spec.description   = spec.summary
  spec.homepage      = "https://gitlab.com/spinny/from"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
