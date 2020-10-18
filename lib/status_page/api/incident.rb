# frozen_string_literal: true

module StatusPage
  # Api Module
  #
  module Api
    # Incident resources in the statuspage.io API
    #
    class Incident
      include Api

      def all(page_id:)
        response = client.get("pages/#{page_id}/incidents")

        handle_response(response) do
          response.body.map do |incident|
            StatusPage::Incident.new(incident)
          end
        end
      end

      def find(page_id:, id:)
        response = client.get("pages/#{page_id}/incidents", id)

        handle_response(response) do
          StatusPage::Incident.new(response.body)
        end
      end

      def create(incident, page_id:)
        json = StatusPage::Serializers::Incident.new(incident,
                                                     update: true).to_json

        response = client.post("pages/#{page_id}/incidents", json)

        handle_response(response) do
          StatusPage::Incident.new(response.body)
        end
      end

      def update(incident, page_id:, id:)
        json = StatusPage::Serializers::Incident.new(incident,
                                                     update: true).to_json
        response = client.put("pages/#{page_id}/incidents", id, json)

        handle_response(response) do
          StatusPage::Incident.new(response.body)
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
      when Net::HTTPBadRequest, Net::HTTPUnprocessableEntity
        raise(Error, response.body)
      end
    end
  end
end
