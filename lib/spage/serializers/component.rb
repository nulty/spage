# frozen_string_literal: true

module Spage
  module Serializers
    # Serializer for the Component resource
    #
    class Component
      def initialize(component, update: false)
        @component = component
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
          'component' => Hash[
            @ivars.map do |name|
              [name[1..-1], @component.instance_variable_get(name)]
            end
          ]
        }
      end

      private

      def ivars(update)
        if update
          @component.instance_variables.select do |name|
            processed_name = name[1..-1]
            update_attrs.include?(processed_name) &&
              !@component.send(processed_name).nil?
          end
        else
          @component.instance_variables
        end
      end

      def update_attrs
        %w[
          description
          status
          name
          only_show_if_degraded
          group_id
          showcase
        ]
      end
    end
  end
end
