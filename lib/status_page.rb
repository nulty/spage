# frozen_string_literal: true

$LOAD_PATH << File.expand_path('./lib')

require 'json'
require 'time'

require 'status_page/version'
require 'status_page/client'
require 'status_page/config'

# Base module for the StatusPage Client
module StatusPage
  class Error < StandardError; end

  autoload :Api, 'status_page/api'
  autoload :Page, 'status_page/resources/page'

  module Api
    autoload :Page, 'status_page/api/page'
  end

  module Serializers
    autoload :Page, 'status_page/serializers/page'
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
    config
  end
end
