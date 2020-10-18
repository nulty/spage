# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StatusPage::Page do
  describe '#all' do
    it 'parses all fields correctly' do
      VCR.use_cassette('all_pages') do
        pages = StatusPage::Api::Page.new.all

        expect(pages.first.id).to eq('hmw075ww7tlq')
      end
    end
  end

  describe '#find' do
    it 'parses all fields correctly' do
      VCR.use_cassette('find_page') do
        page = StatusPage::Api::Page.new.find('hmw075ww7tlq')
        expect(page.updated_at).to be_a(DateTime)
      end
    end
  end

  describe '#update' do
    context '200 page is updated' do
      it 'updates the url' do
        page = VCR.use_cassette('find_page') do
          StatusPage::Api::Page.new.find('hmw075ww7tlq')
        end
        expect(page.url).to be_nil

        page.url = 'https://example.com'

        VCR.use_cassette('update_page_200_page_is_updated') do
          updated_page = StatusPage::Api::Page.new.update('hmw075ww7tlq', page)
          expect(updated_page.url).to eq('https://example.com')
        end
      end
    end

    context '400 page is missing' do
      it 'raises error when body has no "page" root property' do
        page = VCR.use_cassette('find_page') do
          StatusPage::Api::Page.new.find('hmw075ww7tlq')
        end
        expect(page.url).to be_nil

        page.url = 'https://example.com'

        VCR.use_cassette('update_page_400_page_is_missing') do
          expect {
            StatusPage::Api::Page.new.update('hmw075ww7tlq', page)
          }.to raise_error(StatusPage::Error, /page is missing/)
        end
      end
    end
  end
end
