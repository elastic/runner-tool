# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'runner-tool/version'

Gem::Specification.new do |spec|
  spec.name          = "runner-tool"
  spec.version       = RunnerTool::VERSION
  spec.authors       = ["Pere Urbon-Bayes"]
  spec.email         = ["pere.urbon@elasticsearch.com"]

  spec.summary       = %q{A simple tool to execute either commands remotely or local.}
  spec.description   = %q{A simple tool to execute either commands remotely or local.}
  spec.homepage      = "http://www.purbon.com"
  spec.license       = "Apache License 2"

  spec.files         = Dir.glob(["runner-tool.gemspec", "lib/**/*.rb", "spec/**/*.rb"])
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "net-ssh", "~> 2.9", ">= 2.9.4"
  spec.add_runtime_dependency 'net-scp', '~> 1.2', '>= 1.2.1'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
