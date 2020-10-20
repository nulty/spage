require 'spec_helper'

RSpec.describe Spage::Serializers::Page do
  let(:date) { '2020-10-02T10:00:00+00:00' }
  let(:page) do
    Spage::Page.new(
      'created_at' => DateTime.parse(date),
      'css_reds' => { 'thing' => { '5' => :sting, 'updated_at' => date } }
    )
  end

  it 'serializes a page to json' do
    obj = described_class.new(page)

    json = obj.to_json

    parsed = JSON.parse(json)
    expect(parsed['page']).to include('created_at' => date)
    expect(parsed['page']).to include(
      'css_reds' => { 'thing' => { '5' => 'sting', 'updated_at' => date } }
    )
  end

  context 'attrs only for update' do
    it 'selects only update attrs' do
      obj = described_class.new(page, update: true)

      expect(obj.to_json).not_to match(/twitter_logo/)
      # Twitter logo is immutable so shouldn't be in update params
    end
  end
end
