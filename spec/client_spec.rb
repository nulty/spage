require 'spec_helper'

RSpec.describe StatusPage::Client do
  around do |example|
    StatusPage.configure { |c| c.api_key 'invalid_key' }
    example.run
    StatusPage.configure { |c| c.api_key API_KEY }
  end

  describe '#get' do
    it 'Invalid Authentication Token' do
      res = VCR.use_cassette('unauthorized') do
        client = described_class.new
        client.get(:pages)
      end

      expect(res.code).to eq '401'
      expect(res.body).to eq('error' => 'Could not authenticate')
    end
  end
end
