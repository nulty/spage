# frozen_string_literal: true

module StatusPage
  # Api Module
  #
  module Api
    # Page resources in the statuspage.io API
    #
    class Page
      include Api

      def all
        response = client.get(:pages)

        handle_response(response) do
          response.body.map do |page|
            StatusPage::Page.new(page)
          end
        end
      end

      def find(id)
        response = client.get(:pages, id)

        handle_response(response) do
          StatusPage::Page.new(response.body)
        end
      end

      def update(id, page)
        json = StatusPage::Serializers::Page.new(page, update: true).to_json
        response = client.put(:pages, id, json)

        handle_response(response) do
          StatusPage::Page.new(response.body)
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
      when Net::HTTPBadRequest
        raise(Error, response.body)
      end
    end
  end
end
