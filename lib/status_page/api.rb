# frozen_string_literal: true

module StatusPage
  # Mixin for API classes
  #
  module Api
    def client
      @client ||= StatusPage::Client.new
    end
  end
end
