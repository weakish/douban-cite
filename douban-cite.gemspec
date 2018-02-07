# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'douban/cite/version'

Gem::Specification.new do |spec|
  spec.name          = 'douban-cite'
  spec.version       = Douban::Cite::VERSION
  spec.authors       = ['Jakukyo Friel']
  spec.email         = ['weakish@gmail.com']
  spec.summary       = %q{Generate book reference based on douban.}
  spec.description   = %q{A book reference generator. Book information is fetched from [douban](http://www.douban.com).}
  spec.homepage      = 'https://github.com/weakish/douban-cite/'
  spec.license       = 'MIT'
  spec.metadata = {
      'repository' => 'https://github.com/weakish/douban-cite.git',
      'documentation' => 'http://www.rubydoc.info/gems/douban-cite/',
      'issues' => 'https://github.com/weakish/douban-cite/issues',
      'wiki' => 'https://github.com/weakish/ouban-cite/wiki',
  }

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'library_stdnums', '~> 1.4'
  spec.add_runtime_dependency 'rest-client', '~> 1.8'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
