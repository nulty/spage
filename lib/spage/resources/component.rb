# frozen_string_literal: true

module Spage
  # Page resource in statuspage.io
  #
  class Component
    # rubocop: disable Metrics/MethodLength, Metrics/AbcSize
    def initialize(attrs)
      @id               = attrs['id']
      @page_id          = attrs['page_id']
      @created_at       = attrs['created_at']
      @updated_at       = attrs['updated_at']
      @group            = attrs['group']
      @position         = attrs['position']
      @automation_email = attrs['automation_email']

      # Updatable properties
      @description           = attrs['description']
      @status                = attrs['status']
      @name                  = attrs['name']
      @only_show_if_degraded = attrs['only_show_if_degraded']
      @group_id              = attrs['group_id']
      @showcase              = attrs['showcase']
    end
    # rubocop: enable Metrics/MethodLength, Metrics/AbcSize

    # rubocop: disable Layout/LineLength
    attr_reader :id, :page_id, :created_at, :updated_at, :group, :position, :automation_email

    attr_accessor :description, :status, :name, :only_show_if_degraded, :group_id, :showcase
    # rubocop: enable Layout/LineLength

    private

    def date_parse(str)
      return str if str.nil?
      return str if str.is_a?(DateTime)

      DateTime.parse(str)
    end
  end
end
