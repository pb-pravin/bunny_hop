# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bunny_hop/version'

Gem::Specification.new do |gem|
  gem.name          = 'bunny_hop'
  gem.version       = BunnyHop::VERSION
  gem.authors       = ['Jeremy Israelsen']
  gem.email         = ['jisraelsen@gmail.com']
  gem.description   = 'Simple wrapper for Bunny'
  gem.summary       = 'Simple wrapper for Bunny'
  gem.homepage      = 'http://jisraelsen.github.com/drudgery'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_dependency 'bunny', '~> 0.8'
  gem.add_dependency 'json',  '~> 1.7'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bundler',             '~> 1.2'
  gem.add_development_dependency 'mocha',               '~> 0.12'
  gem.add_development_dependency 'simplecov',           '~> 0.6'
  gem.add_development_dependency 'guard-minitest',      '~> 0.5'
end
