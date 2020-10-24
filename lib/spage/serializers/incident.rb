# frozen_string_literal: true

module Spage
  module Serializers
    # Serializer for the Page resource
    #
    class Incident
      def initialize(incident, update: false)
        @incident = incident
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
          'incident' => Hash[
            @ivars.map do |name|
              [name[1..-1], @incident.instance_variable_get(name)]
            end
          ]
        }
      end

      private

      def ivars(update)
        if update
          @incident.instance_variables.select do |name|
            processed_name = name[1..-1]
            update_attrs.include?(processed_name) &&
              !@incident.send(processed_name).nil?
          end
        else
          @incident.instance_variables
        end
      end

      # rubocop: disable Metrics/MethodLength
      def update_attrs
        %w[
          name
          status
          impact_override
          scheduled_for
          scheduled_until
          scheduled_remind_prior
          scheduled_auto_in_progress
          scheduled_auto_completed
          metadata
          deliver_notifications
          auto_transition_deliver_notifications_at_end
          auto_transition_deliver_notifications_at_start
          auto_transition_to_maintenance_state
          auto_transition_to_operational_state
          auto_tweet_at_beginning
          auto_tweet_on_completion
          auto_tweet_on_creation
          auto_tweet_one_hour_before
          backfill_date
          backfilled
          body
          components
          component_ids
          scheduled_auto_transition
        ]
      end
      # rubocop: enable Metrics/MethodLength
    end
  end
end
