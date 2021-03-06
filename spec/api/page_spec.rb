# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spage::Page do
  describe '#all' do
    it 'parses all fields correctly' do
      VCR.use_cassette('pages/all') do
        pages = Spage::Api::Page.new.all

        expect(pages.first.id).to eq('hmw075ww7tlq')
      end
    end
  end

  describe '#find' do
    it 'parses all fields correctly' do
      VCR.use_cassette('pages/find') do
        page = Spage::Api::Page.new.find('hmw075ww7tlq')
        expect(page.updated_at).to be_a(DateTime)
      end
    end
  end

  describe '#update' do
    context '200 page is updated' do
      it 'updates the url' do
        page = VCR.use_cassette('pages/find') do
          Spage::Api::Page.new.find('hmw075ww7tlq')
        end
        expect(page.url).to be_nil

        page.url = 'https://example.com'

        VCR.use_cassette('pages/update_200_page_is_updated') do
          updated_page = Spage::Api::Page.new.update('hmw075ww7tlq', page)
          expect(updated_page.url).to eq('https://example.com')
        end
      end
    end

    context '400 page is missing' do
      it 'raises error when body has no "page" root property' do
        page = VCR.use_cassette('pages/find') do
          Spage::Api::Page.new.find('hmw075ww7tlq')
        end
        expect(page.url).to be_nil

        page.url = 'https://example.com'

        VCR.use_cassette('pages/update_400_page_is_missing') do
          expect {
            Spage::Api::Page.new.update('hmw075ww7tlq', page)
          }.to raise_error(Spage::Error, /page is missing/)
        end
      end
    end
  end
end
