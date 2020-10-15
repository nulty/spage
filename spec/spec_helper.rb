# frozen_string_literal: true

# Set VCR && STATUSPAGE_API_KEY envvar when recording cassettes
if ENV['VCR']
  API_KEY = ENV.fetch('STATUSPAGE_API_KEY', raise(ArgumentError, 'No api key provided'))
else
  API_KEY = 'NULL'
end

require 'bundler/setup'
require 'status_page'
require 'vcr'
require 'pry'

StatusPage.configure do |c|
  c.api_key API_KEY
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  # Hide API key used for testing in cassettes
  config.filter_sensitive_data('<Oauth *****>') do |interaction|
    interaction.request.headers['Authorization'].first
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def file_fixture(path)
    Pathname.new(File.dirname(__FILE__) + '/fixtures').join(path)
  end
end
