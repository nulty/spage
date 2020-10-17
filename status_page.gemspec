require_relative 'lib/status_page/version'

Gem::Specification.new do |spec|
  spec.name          = "status_page"
  spec.version       = StatusPage::VERSION
  spec.authors       = ["Iain McNulty"]
  spec.email         = ["iain@inulty.com"]

  spec.summary       = %q{Ruby Client for using the StatusPage API}
  spec.description   = %q{Ruby client for making requests the StatusPage API}
  spec.homepage      = "https://github.com/nulty/status_page"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nulty/status_page"
  spec.metadata["changelog_uri"] = "https://github.com/nulty/status_page/CHANGELOG.md"

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
