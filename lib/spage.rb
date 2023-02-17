# frozen_string_literal: true

$LOAD_PATH << File.expand_path('./lib')

require 'json'
require 'time'

require 'spage/version'
require 'spage/client'
require 'spage/config'

# Base module for the Spage Client
module Spage
  class Error < StandardError; end

  autoload :Api, 'spage/api'
  autoload :Page, 'spage/resources/page'
  autoload :Incident, 'spage/resources/incident'
  autoload :IncidentUpdate, 'spage/resources/incident_update'
  autoload :Component, 'spage/resources/component'

  module Api
    autoload :Page, 'spage/api/page'
    autoload :Incident, 'spage/api/incident'
    autoload :IncidentUpdate, 'spage/api/incident_update'
    autoload :Component, 'spage/api/component'
  end

  module Serializers
    autoload :Page, 'spage/serializers/page'
    autoload :Incident, 'spage/serializers/incident'
    autoload :IncidentUpdate, 'spage/serializers/incident_update'
    autoload :Component, 'spage/serializers/component'
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
    config
  end
end
