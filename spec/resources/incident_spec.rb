# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spage::Incident do
  describe 'builds a model from json' do
    it 'parses all fields correctly' do
      VCR.use_cassette('incidents/all') do
        incidents = Spage::Api::Incident.new.all(page_id: 'hmw075ww7tlq')
        expect(incidents.first).to be_a(Spage::Incident)
      end
    end
  end
end
