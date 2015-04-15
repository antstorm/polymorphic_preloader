# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polymorphic_preloader/version'

Gem::Specification.new do |spec|
  spec.name          = 'polymorphic_preloader'
  spec.version       = PolymorphicPreloader::VERSION
  spec.authors       = ['Anthony Dmitriyev']
  spec.email         = ['antstorm@gmail.com']
  spec.summary       = 'Eager loading nested polymorphic associations in ActiveRecord'
  spec.homepage      = 'https://github.com/antstorm/polymorphic_preloader'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.require_paths = ['lib']
end
