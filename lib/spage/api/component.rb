# frozen_string_literal: true

module Spage
  # Api Module
  #
  module Api
    # Component resources in the statuspage.io API
    #
    class Component
      include Api

      def create(component, page_id:)
        json = Spage::Serializers::Component.new(component,
                                                 update: true).to_json
        response = client.post("pages/#{page_id}/components", json)

        handle_response(response) do
          Spage::Component.new(response.body)
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
