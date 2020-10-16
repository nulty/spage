# frozen_string_literal: true

module StatusPage
  module Serializers
    # Serializer for the Page resource
    #
    class Page
      def initialize(page, update: false)
        @page = page
        @ivars = ivars(update)
      end

      def to_json(obj = nil)
        as_json.to_json(obj)
      end

      def as_json
        to_hash
      end

      def to_hash
        {
          'page' => Hash[
            @ivars.map do |name|
              [name[1..-1], @page.instance_variable_get(name)]
            end
          ]
        }
      end

      private

      def ivars(update)
        if update
          @page.instance_variables.select do |name|
            update_attrs.include?(name[1..-1])
          end
        else
          @page.instance_variables
        end
      end

      # rubocop: disable Metrics/MethodLength
      def update_attrs
        %w[
          name
          domain
          subdomain
          url
          branding
          css_body_background_color
          css_font_color
          css_light_font_color
          css_greens
          css_yellows
          css_oranges
          css_reds
          css_blues
          css_border_color
          css_graph_color
          css_link_color
          css_no_data
          hidden_from_search
          viewers_must_be_team_members
          allow_page_subscribers
          allow_incident_subscribers
          allow_email_subscribers
          allow_sms_subscribers
          allow_rss_atom_feeds
          allow_webhook_subscribers
          notifications_from_email
          time_zone
          notifications_email_footer
        ]
      end
      # rubocop: enable Metrics/MethodLength
    end
  end
end
