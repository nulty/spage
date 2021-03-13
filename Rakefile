require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'github_changelog_generator/task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'nulty'
  config.project = 'spage'
  config.exclude_labels = %w[duplicate question invalid wontfix weekly-digest]
end
