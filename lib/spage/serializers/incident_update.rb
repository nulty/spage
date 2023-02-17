# frozen_string_literal: true

module Spage
  module Serializers
    class IncidentUpdate
      def initialize(incident_update, update: false)
        @incident_update = incident_update
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
          'incident_update' => Hash[
            @ivars.map do |name|
              [name[1..-1], @incident_update.instance_variable_get(name)]
            end
          ]
        }
      end

      private

      def ivars(update)
        if update
          @incident_update.instance_variables.select do |name|
            processed_name = name[1..-1]
            update_attrs.include?(processed_name) &&
              !@incident_update.send(processed_name).nil?
          end
        else
          @incident_update.instance_variables
        end
      end

      def update_attrs
        %w[
          body
          deliver_notifications
          display_at
          wants_twitter_update
        ]
      end
    end
  end
end
