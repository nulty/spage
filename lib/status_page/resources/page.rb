# frozen_string_literal: true

module StatusPage
  # Page resource in statuspage.io
  #
  class Page
    # rubocop: disable Metrics/MethodLength, Metrics/AbcSize
    def initialize(attrs)
      @id = attrs['id']
      @created_at = date_parse(attrs['created_at'])
      @updated_at = date_parse(attrs['updated_at'])
      @name = attrs['name']
      @page_description = attrs['page_description']
      @headline = attrs['headline']
      @branding = attrs['branding']
      @subdomain = attrs['subdomain']
      @domain = attrs['domain']
      @url = attrs['url']
      @support_url = attrs['support_url']
      @hidden_from_search = attrs['hidden_from_search']
      @allow_page_subscribers = attrs['allow_page_subscribers']
      @allow_incident_subscribers = attrs['allow_incident_subscribers']
      @allow_email_subscribers = attrs['allow_email_subscribers']
      @allow_sms_subscribers = attrs['allow_sms_subscribers']
      @allow_rss_atom_feeds = attrs['allow_rss_atom_feeds']
      @allow_webhook_subscribers = attrs['allow_webhook_subscribers']
      @notifications_from_email = attrs['notifications_from_email']
      @notifications_email_footer = attrs['notifications_email_footer']
      @activity_score = attrs['activity_score']
      @twitter_username = attrs['twitter_username']
      @viewers_must_be_team_members = attrs['viewers_must_be_team_members']
      @ip_restrictions = attrs['ip_restrictions']
      @city = attrs['city']
      @state = attrs['state']
      @country = attrs['country']
      @time_zone = attrs['time_zone']
      @css_body_background_color = attrs['css_body_background_color']
      @css_font_color = attrs['css_font_color']
      @css_light_font_color = attrs['css_light_font_color']
      @css_greens = attrs['css_greens']
      @css_yellows = attrs['css_yellows']
      @css_oranges = attrs['css_oranges']
      @css_blues = attrs['css_blues']
      @css_reds = attrs['css_reds']
      @css_border_color = attrs['css_border_color']
      @css_graph_color = attrs['css_graph_color']
      @css_link_color = attrs['css_link_color']
      @css_no_data = attrs['css_no_data']
      @favicon_logo = attrs['favicon_logo']
      @transactional_logo = attrs['transactional_logo']
      @hero_cover = attrs['hero_cover']
      @email_logo = attrs['email_logo']
      @twitter_logo = attrs['twitter_logo']
    end
    # rubocop: enable Metrics/MethodLength, Metrics/AbcSize

    # rubocop: disable Layout/LineLength
    attr_reader :id, :created_at, :updated_at, :name, :page_description, :headline, :branding, :subdomain, :domain, :url, :support_url, :hidden_from_search, :allow_page_subscribers, :allow_incident_subscribers, :allow_email_subscribers, :allow_sms_subscribers, :allow_rss_atom_feeds, :allow_webhook_subscribers, :notifications_from_email, :notifications_email_footer, :activity_score, :twitter_username, :viewers_must_be_team_members, :ip_restrictions, :city, :state, :country, :time_zone, :css_body_background_color, :css_font_color, :css_light_font_color, :css_greens, :css_yellows, :css_oranges, :css_blues, :css_reds, :css_border_color, :css_graph_color, :css_link_color, :css_no_data, :favicon_logo, :transactional_logo, :hero_cover, :email_logo, :twitter_logo
    # rubocop: enable Layout/LineLength

    def date_parse(str)
      return str if str.nil?
      return str if str.is_a?(DateTime)

      DateTime.parse(str)
    end
  end
end
