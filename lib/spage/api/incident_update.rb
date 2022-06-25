# frozen_string_literal: true

module Spage
  # Api Module
  #
  module Api
    # Incident resources in the statuspage.io API
    #
    class IncidentUpdate
      include Api

      def update(incident_update, id, page_id:)
        json = Spage::Serializers::IncidentUpdate.new(incident_update,
                                                      update: true).to_json

        response = client.patch(
          "pages/#{page_id}/incidents/#{incident_update.incident_id}/incident_updates", id, json
        )

        handle_response(response) do
          Spage::IncidentUpdate.new(response.body)
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
