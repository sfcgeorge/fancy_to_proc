# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fancy_to_proc/version"

Gem::Specification.new do |spec|
  spec.name          = "fancy_to_proc"
  spec.version       = FancyToProc::VERSION
  spec.authors       = ["Simon George"]
  spec.email         = ["simon@sfcgeorge.co.uk"]

  spec.summary       = %q{Makes Symbol#to_proc chainable and take arguments}
  spec.description   = %q{Have you ever wished Symbol#to_proc was chainable and took arguments? Now it does.}
  spec.homepage      = "https://github.com/sfcgeorge/fancy_to_proc"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
