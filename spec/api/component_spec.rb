# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spage::Api::Component do
  describe '#all' do
    it 'returns a collection of Components' do
      VCR.use_cassette('components/all') do
        components = Spage::Api::Component.new.all(page_id: 'hmw075ww7tlq')

        expect(components).to respond_to(:each)
        expect(components.first).to be_a(Spage::Component)
      end
    end
  end

  describe '#find' do
    it 'returns an Component' do
      VCR.use_cassette('components/find') do
        component = Spage::Api::Component.new.find(
          page_id: 'hmw075ww7tlq',
          id: '3sxkhns1ndms'
        )

        expect(component).to be_a(Spage::Component)
        expect(component.page_id).to eq('hmw075ww7tlq')
        expect(component.id).to eq('3sxkhns1ndms')
      end
    end
  end

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
