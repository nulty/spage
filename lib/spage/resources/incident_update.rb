# frozen_string_literal: true

module Spage
  # Page resource in statuspage.io
  #
  class IncidentUpdate
    # rubocop: disable Metrics/MethodLength, Metrics/AbcSize
    def initialize(attrs)
      @id                    = attrs['id']
      @incident_id           = attrs['incident_id']
      @affected_components   = attrs['affected_components']
      @body                  = attrs['body']
      @custom_tweet          = bool(attrs['custom_tweet'])
      @deliver_notifications = attrs['deliver_notifications']
      @display_at            = date_parse(attrs['display_at'])
      @status                = attrs['status']
      @tweet_id              = attrs['tweet_id']
      @twitter_updated_at    = date_parse(attrs['twitter_updated_at'])
      @wants_twitter_update  = bool(attrs['wants_twitter_update'])
      @created_at            = date_parse(attrs['created_at'])
      @updated_at            = date_parse(attrs['updated_at'])

      # vars only used to update/create incident_update
    end
    # rubocop: enable Metrics/MethodLength, Metrics/AbcSize

    attr_accessor :incident_id,
                  :body,
                  :deliver_notifications,
                  :display_at,
                  :wants_twitter_update
    attr_reader :id,
                :affected_components,
                :custom_tweet,
                :status,
                :tweet_id,
                :twitter_updated_at,
                :updated_at,
                :created_at

    private

    def date_parse(str)
      return str if str.nil?
      return str if str.is_a?(DateTime)

      DateTime.parse(str)
    end

    def bool(val)
      case val
      when '1' then true
      when '0' then false
      end
    end
  end
end
