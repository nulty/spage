# frozen_string_literal: true

module StatusPage
  # Global Configuration for the StatusPage Client
  #
  class Config
    def initialize
      @api_endpoint = 'https://api.statuspage.io'
      @api_version = 'v1'
    end

    def api_key(api_key = nil)
      (api_key && @api_key = api_key) || @api_key
    end

    def api_version(api_version = nil)
      (api_version && @api_version = api_version) || @api_version
    end
  end
end
