# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intergrala/version'

Gem::Specification.new do |spec|
  spec.name          = "intergrala"
  spec.version       = Intergrala::VERSION
  spec.authors       = ["Patrick Metcalfe"]
  spec.email         = ["git@patrickmetcalfe.com"]
  spec.summary       = %q{A web application for Chief O'Keefe's BC Calculus class}
  spec.description   = %q{It demonstrates different intergration methods.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
