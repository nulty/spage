# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StatusPage::Page do
  describe 'builds a model from json' do
    it 'parses all fields correctly' do
      VCR.use_cassette('all_pages') do
        pages = StatusPage::Api::Page.new.all
        expect(pages.first).to be_a StatusPage::Page
      end
    end
  end
end
