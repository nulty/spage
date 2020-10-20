# frozen_string_literal: true

module Spage
  # Mixin for API classes
  #
  module Api
    def client
      @client ||= Spage::Client.new
    end
  end
end
