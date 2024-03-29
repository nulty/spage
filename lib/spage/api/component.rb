# frozen_string_literal: true

module Spage
  # Api Module
  #
  module Api
    # Component resources in the statuspage.io API
    #
    class Component
      include Api

      def all(page_id:, per_page: 100, page: 1)
        response = client.get("pages/#{page_id}/components", query: "per_page=#{per_page}&page=#{page}")

        handle_response(response) do
          response.body.map do |component|
            Spage::Component.new(component)
          end
        end
      end

      def find(page_id:, id:)
        response = client.get("pages/#{page_id}/components", id)

        handle_response(response) do
          Spage::Component.new(response.body)
        end
      end

      def create(component, page_id:)
        json = Spage::Serializers::Component.new(component,
                                                 update: true).to_json
        response = client.post("pages/#{page_id}/components", json)

        handle_response(response) do
          Spage::Component.new(response.body)
        end
      end

      def update(component, page_id:, id:)
        json = Spage::Serializers::Component.new(component,
                                                 update: true).to_json
        response = client.put("pages/#{page_id}/components", id, json)

        handle_response(response) do
          Spage::Component.new(response.body)
        end
      end

      def delete(page_id:, id:)
        response = client.delete("pages/#{page_id}/components", id)

        handle_response(response) do
          true
        end
      end
    end

    private

    def handle_response(response)
      case response
      when Net::HTTPSuccess
        yield
      when Net::HTTPUnauthorized
        raise(Error, 'Unauthorized: wrong API Key')
      else
        # Net::HTTPBadRequest, Net::HTTPUnprocessableEntity, Net::HTTPForbidden
        raise(Error, response.body)
      end
    end
  end
end
