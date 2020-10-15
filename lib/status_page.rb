# frozen_string_literal: true

$LOAD_PATH << File.expand_path('./lib')
require 'status_page/version'
require 'status_page/client'
require 'status_page/config'

# Base module for the StatusPage Client
module StatusPage
  class Error < StandardError; end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
    config
  end
end
