require_relative 'lib/spage/version'

Gem::Specification.new do |spec|
  spec.name          = "spage"
  spec.version       = Spage::VERSION
  spec.authors       = ["Iain McNulty"]
  spec.email         = ["iain@inulty.com"]

  spec.summary       = %q{Ruby Client for using the Spage API}
  spec.description   = %q{Ruby client for making requests the Spage API}
  spec.homepage      = "https://github.com/nulty/spage"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nulty/spage"
  spec.metadata["changelog_uri"] = "https://github.com/nulty/spage/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "simplecov"

end
