# frozen_string_literal: true

module Spage
  # Global Configuration for the Spage Client
  #
  class Config
    def initialize
      @api_endpoint = 'https://api.statuspage.io'
      @api_version = 'v1'
      @api_key = nil
    end

    def api_key(api_key = nil)
      (api_key && @api_key = api_key) || @api_key
    end

    def api_version(api_version = nil)
      (api_version && @api_version = api_version) || @api_version
    end
  end
end
