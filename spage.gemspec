# frozen_string_literal: true

require_relative 'lib/spage/version'

Gem::Specification.new do |spec|
  spec.name          = 'spage'
  spec.version       = Spage::VERSION
  spec.authors       = ['Iain McNulty']
  spec.email         = ['iain@inulty.com']

  spec.summary       = 'Ruby client for using the statuspage.io API'
  spec.description   = 'Ruby client for making requests the statuspage.io API'
  spec.homepage      = 'https://github.com/nulty/spage'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/nulty/spage'
  spec.metadata['changelog_uri'] = 'https://github.com/nulty/spage/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end
