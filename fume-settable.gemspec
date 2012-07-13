# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["Sunteya"]
  gem.email         = ["Sunteya@gmail.com"]
  gem.description   = "a simple settings plugin for read on yaml, ruby, database, etc"
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "fume-settable"
  gem.require_paths = ["lib"]
  gem.version       = File.read(File.expand_path("../VERSION", __FILE__)).chomp

  gem.add_dependency "hashie"
  gem.add_dependency "activesupport", ">= 3.0"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "version"
end
