# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bg/common/version'

Gem::Specification.new do |spec|
  spec.name          = "bg-common"
  spec.version       = BG::Common::VERSION
  spec.authors       = ["Youssef Chaker"]
  spec.email         = ["youssef@bearandgiraffe.com"]

  spec.summary       = 'A Ruby library of common behaviors, especially for Ruby on Rails applications.'
  spec.description   = 'A Ruby library of common behaviors, especially for Ruby on Rails applications.'
  spec.homepage      = 'https://github.com/bearandgiraffe/bg-common'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
