require 'spec_helper'

RSpec.describe Spage::Client do
  around do |example|
    Spage.configure { |c| c.api_key 'invalid_key' }
    example.run
    Spage.configure { |c| c.api_key API_KEY }
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
