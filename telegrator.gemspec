# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telegrator/version'

Gem::Specification.new do |spec|
  spec.name          = 'telegrator'
  spec.version       = Telegrator::VERSION
  spec.authors       = ['Aleksey Ivanov']
  spec.email         = ['ialexxei@gmail.com']

  spec.summary       = 'A generator to set up new Telegram bot easily'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ivanovaleksey/telegrator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'thor', '~> 0.19.1'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rubocop', '~> 0.48.1'
end
