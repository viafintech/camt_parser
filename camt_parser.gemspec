# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'camt_parser/version'

Gem::Specification.new do |spec|
  # For explanations see http://docs.rubygems.org/read/chapter/20
  spec.name          = "camt_parser"
  spec.version       = CamtParser::VERSION
  spec.authors       = ["Tobias Schoknecht"]
  spec.email         = ["tobias.schoknecht@viafintech.com"]
  spec.description   = %q{A parser for the Camt file format}
  spec.summary       = %q{Gem for parsing camt files into a speaking object.}
  spec.homepage      = "https://github.com/viafintech/camt_parser"
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb', 'lib/**/*.rake'] # Important!
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake",                  "~> 13.0.1"
  spec.add_development_dependency "rspec",                 "~> 3.3.0"
  spec.add_development_dependency "builder",               "~> 3.2.2"

  spec.add_runtime_dependency "nokogiri"
end
