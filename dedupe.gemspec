# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dedupe/version'

Gem::Specification.new do |spec|
  spec.name          = "dedupe"
  spec.version       = Dedupe::VERSION
  spec.authors       = ["Claire Tran"]
  spec.email         = ["c.tran83@gmail.com"]
  spec.summary       = %q{Dedupe and sort a large file}
  spec.description   = %q{To read a large file and dedupe and sort the file with limited memory}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['run']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
end
