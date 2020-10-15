# frozen_string_literal: true

require 'net/http'

BASE_URL = 'api.statuspage.io'

module StatusPage
  # HTTP client for making requests to statuspage.io
  #
  class Client
    def initialize
      @api_key = StatusPage.config.api_key
      @api_version = StatusPage.config.api_version
    end

    def get(resource, id = nil)
      path = [@api_version, resource, id].compact.join('/')
      uri = URI::HTTP.build(host: BASE_URL, path: "/#{path}")

      request = Net::HTTP::Get.new(uri)
      request.add_field('Authorization', "OAuth #{@api_key}")
      request.add_field('Content-Type', 'application/json')

      res = Net::HTTP.start(uri.hostname, use_ssl: true) do |http|
        http.request(request)
      end

      yield(res) if block_given?
      res
    end
  end
end
