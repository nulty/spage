# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spage::Api::Component do
  describe '#create' do
    context '403 missing component body' do
      it 'raises error: component payload is empty' do
        component = Spage::Component.new({})

        expect {
          VCR.use_cassette('components/create_403_missing_params') do
            Spage::Api::Component.new
              .create(component, page_id: 'hmw075ww7tlq')
          end
        }.to raise_error(Spage::Error, /Parameter component is required/)
      end
    end

    context '422 incomplete params' do
      it 'raises error: component name can\'t be blank' do
        component = Spage::Component.new('description' => 'asasdf')

        expect {
          VCR.use_cassette('components/create_422_incomplete_params') do
            Spage::Api::Component.new
              .create(component, page_id: 'hmw075ww7tlq')
          end
        }.to raise_error(Spage::Error, /Name can't be blank/)
      end
    end

    context '201 component created' do
      it 'creates a new component for component on a page' do
        component = Spage::Component.new('name' => 'Created an Component')

        VCR.use_cassette('components/create') do
          created_component = Spage::Api::Component.new
            .create(component, page_id: 'hmw075ww7tlq')

          expect(created_component.name).to eq('Created an Component')
        end
      end
    end
  end
end