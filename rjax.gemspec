# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rjax/version'

Gem::Specification.new do |spec|
  spec.name          = "rjax"
  spec.version       = Rjax::VERSION
  spec.authors       = ["Sergey Pchelincev"]
  spec.email         = ["jalkoby91@gmail.com"]
  spec.description   = %q{Elegant responder for ajax requests}
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack", ">= 3.1.0"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.0"
  spec.add_development_dependency "rack-test"
end
