# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StatusPage::Incident do
  describe 'builds a model from json' do
    it 'parses all fields correctly' do
      VCR.use_cassette('all_incidents') do
        incidents = StatusPage::Api::Incident.new.all(page_id: 'hmw075ww7tlq')
        expect(incidents.first).to be_a(StatusPage::Incident)
      end
    end
  end
end