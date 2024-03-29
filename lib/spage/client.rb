# frozen_string_literal: true

require 'net/http'
require 'json'

BASE_URL = 'api.statuspage.io'

module Spage
  # HTTP client for making requests to statuspage.io
  #
  class Client
    def initialize
      @api_key = Spage.config.api_key
      @api_version = Spage.config.api_version
    end

    def get(resource, id = nil, query: nil)
      make_request(Net::HTTP::Get, resource, id, query: query)
    end

    def put(resource, id, body)
      make_request(Net::HTTP::Put, resource, id, body)
    end

    def post(resource, body)
      make_request(Net::HTTP::Post, resource, nil, body)
    end

    def delete(resource, id)
      make_request(Net::HTTP::Delete, resource, id)
    end

    # rubocop: disable Metrics/MethodLength, Metrics/AbcSize
    def make_request(http_method, resource, id, body = nil, query: nil)
      path = [@api_version, resource, id].compact.join('/')
      uri = URI::HTTP.build(host: BASE_URL, path: "/#{path}", query: query)

      request = http_method.new(uri)
      request.add_field('Authorization', "OAuth #{@api_key}")
      request.add_field('Content-Type', 'application/json')

      request.body = body if request.request_body_permitted?

      res = Net::HTTP.start(uri.hostname, use_ssl: true) do |http|
        response = http.request(request)

        response.body = JSON.parse(response.body) if response.body
        response
      end

      yield(res) if block_given?
      res
    end
    # rubocop: enable Metrics/MethodLength, Metrics/AbcSize
  end
end
