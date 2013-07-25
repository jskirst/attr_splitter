# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attr_splitter/version'

Gem::Specification.new do |spec|
  spec.name          = "attr_splitter"
  spec.version       = AttrSplitter::VERSION
  spec.authors       = ["Jonathan Kirst"]
  spec.email         = ["jskirst@gmail.com"]
  spec.description   = %q{ 
    Split an attribute into multiple virtual attributes, 
    and use a new FormBuilder method called multi_text_field to allow users to enter a long field in individual pieces.
    Useful for fields with discrete break points, like social security numbers or phone numbers. }
  spec.summary       = %q{Split attributes into bite size pieces.}
  spec.homepage      = "https://github.com/jskirst/attr_splitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "supermodel"
  spec.add_development_dependency "actionpack"
end
