# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spage::Page do
  describe 'builds a model from json' do
    it 'parses all fields correctly' do
      VCR.use_cassette('pages/all') do
        pages = Spage::Api::Page.new.all
        expect(pages.first).to be_a Spage::Page
      end
    end
  end
end
