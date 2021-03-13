# frozen_string_literal: true

module Spage
  # Page resource in statuspage.io
  #
  class Incident
    # rubocop: disable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength
    def initialize(attrs)
      @id                              = attrs['id']
      @components                      = attrs['components'] # Array of Component
      @impact                          = attrs['impact']
      @impact_override                 = attrs['impact_override']
      @incident_updates                = attrs['incident_updates'] # Array of IncidentUpdate
      @metadata                        = attrs['metadata'] # Hash of values
      @name                            = attrs['name']
      @page_id                         = attrs['page_id']
      @postmortem_body                 = attrs['postmortem_body']
      @postmortem_body_last_updated_at = attrs['postmortem_body_last_updated_at']
      @postmortem_ignored              = attrs['postmortem_ignored']
      @postmortem_notified_subscribers = attrs['postmortem_notified_subscribers']
      @postmortem_notified_twitter     = attrs['postmortem_notified_twitter']
      @postmortem_published_at         = attrs['postmortem_published_at']
      @scheduled_auto_completed        = attrs['scheduled_auto_completed']
      @scheduled_auto_in_progress      = attrs['scheduled_auto_in_progress']
      @scheduled_for                   = attrs['scheduled_for']
      @scheduled_remind_prior          = attrs['scheduled_remind_prior']
      @scheduled_reminded_at           = date_parse(attrs['scheduled_reminded_at'])
      @scheduled_until                 = attrs['scheduled_until']
      @shortlink                       = attrs['shortlink']
      @status                          = attrs['status']
      @monitoring_at                   = date_parse(attrs['monitoring_at'])
      @resolved_at                     = date_parse(attrs['resolved_at'])
      @created_at                      = date_parse(attrs['created_at'])
      @updated_at                      = date_parse(attrs['updated_at'])

      # vars only used to update/create incident
      @deliver_notifications                          = attrs['deliver_notifications']
      @auto_transition_deliver_notifications_at_end   = attrs['auto_transition_deliver_notifications_at_end']
      @auto_transition_deliver_notifications_at_start = attrs['auto_transition_deliver_notifications_at_start']
      @auto_transition_to_maintenance_state           = attrs['auto_transition_to_maintenance_state']
      @auto_transition_to_operational_state           = attrs['auto_transition_to_operational_state']
      @auto_tweet_at_beginning                        = attrs['auto_tweet_at_beginning']
      @auto_tweet_on_completion                       = attrs['auto_tweet_on_completion']
      @auto_tweet_on_creation                         = attrs['auto_tweet_on_creation']
      @auto_tweet_one_hour_before                     = attrs['auto_tweet_one_hour_before']
      @backfill_date                                  = attrs['backfill_date']
      @backfilled                                     = attrs['backfilled']
      @body                                           = attrs['body']
      @component_ids                                  = attrs['component_ids']
      @scheduled_auto_transition                      = attrs['scheduled_auto_transition']
    end
    # rubocop: enable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

    # rubocop: disable Layout/LineLength
    attr_reader :id, :created_at, :impact, :incident_updates, :monitoring_at, :page_id, :postmortem_body, :postmortem_body_last_updated_at, :postmortem_ignored, :postmortem_notified_subscribers, :postmortem_notified_twitter, :postmortem_published_at, :resolved_at, :shortlink, :updated_at

    attr_accessor :name, :status, :impact_override, :scheduled_for, :scheduled_until, :scheduled_remind_prior, :scheduled_reminded_at, :scheduled_auto_in_progress, :scheduled_auto_completed, :metadata, :deliver_notifications, :auto_transition_deliver_notifications_at_end, :auto_transition_deliver_notifications_at_start, :auto_transition_to_maintenance_state, :auto_transition_to_operational_state, :auto_tweet_at_beginning, :auto_tweet_on_completion, :auto_tweet_on_creation, :auto_tweet_one_hour_before, :backfill_date, :backfilled, :body, :components, :component_ids, :scheduled_auto_transition
    # rubocop: enable Layout/LineLength

    private

    def date_parse(str)
      return str if str.nil?
      return str if str.is_a?(DateTime)

      DateTime.parse(str)
    end
  end
end
