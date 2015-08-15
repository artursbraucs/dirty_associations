# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dirty_nested_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = 'dirty_nested_attributes'
  spec.version       = DirtyNestedAttributes::VERSION
  spec.authors       = ['Arturs Braucs']
  spec.email         = ['arturs.braucs@gmail.com']

  spec.summary       = 'Tracks nested association changes in ActiveRecord objects.'
  spec.description   = 'Tracks nested association changes in ActiveRecord objects.
  Marks all changes in parent if something in child (one to one, one to many) records has changed.'
  spec.homepage      = 'https://github.com/artursbraucs/dirty_associations'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 4'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  if RUBY_PLATFORM == 'java'
    spec.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
  else
    spec.add_development_dependency 'sqlite3'
  end
  spec.add_development_dependency 'rails', '>= 4'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
