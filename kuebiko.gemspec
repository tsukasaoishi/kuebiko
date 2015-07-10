# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kuebiko/version'

Gem::Specification.new do |spec|
  spec.name          = "kuebiko"
  spec.version       = Kuebiko::VERSION
  spec.authors       = ["tsukasaoishi"]
  spec.email         = ["tsukasa.oishi@gmail.com"]

  spec.summary       = %q{Kuebiko generates URLs from ruby code.}
  spec.description   = %q{Kuebiko generates URLs from ruby code.}
  spec.homepage      = "https://github.com/tsukasaoishi/kuebiko"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
