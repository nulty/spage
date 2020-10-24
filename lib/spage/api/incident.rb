# frozen_string_literal: true

module Spage
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
            Spage::Incident.new(incident)
          end
        end
      end

      def unresolved(page_id:)
        response = client.get("pages/#{page_id}/incidents/unresolved")

        handle_response(response) do
          response.body.map do |incident|
            Spage::Incident.new(incident)
          end
        end
      end

      def scheduled(page_id:)
        response = client.get("pages/#{page_id}/incidents/scheduled")

        handle_response(response) do
          response.body.map do |incident|
            Spage::Incident.new(incident)
          end
        end
      end

      def active_maintenance(page_id:)
        response = client.get("pages/#{page_id}/incidents/active_maintenance")

        handle_response(response) do
          response.body.map do |incident|
            Spage::Incident.new(incident)
          end
        end
      end

      def find(page_id:, id:)
        response = client.get("pages/#{page_id}/incidents", id)

        handle_response(response) do
          Spage::Incident.new(response.body)
        end
      end

      def create(incident, page_id:)
        json = Spage::Serializers::Incident.new(incident,
                                                update: true).to_json

        response = client.post("pages/#{page_id}/incidents", json)

        handle_response(response) do
          Spage::Incident.new(response.body)
        end
      end

      def update(incident, page_id:, id:)
        json = Spage::Serializers::Incident.new(incident,
                                                update: true).to_json
        response = client.put("pages/#{page_id}/incidents", id, json)

        handle_response(response) do
          Spage::Incident.new(response.body)
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
