# frozen_string_literal: true

require 'spec_helper'

RSpec.describe StatusPage::Api::Incident do
  describe '#all' do
    it 'returns a collection of Incidents' do
      VCR.use_cassette('all_incidents') do
        incidents = StatusPage::Api::Incident.new.all(page_id: 'hmw075ww7tlq')

        expect(incidents).to respond_to(:each)
        expect(incidents.first).to be_a(StatusPage::Incident)
        expect(incidents.first.id).to eq('72vkct8p5tk8')
      end
    end
  end

  describe '#all' do
    it 'returns a collection of Incidents' do
      VCR.use_cassette('unresolved_incidents') do
        incidents = StatusPage::Api::Incident.new.all(page_id: 'hmw075ww7tlq')

        expect(incidents).to respond_to(:each)
        expect(incidents.first).to be_a(StatusPage::Incident)
        expect(incidents.first.id).to eq('72vkct8p5tk8')
      end
    end
  end

  describe '#find' do
    it 'returns an Incident' do
      VCR.use_cassette('find_incident') do
        incident = StatusPage::Api::Incident.new.find(
          page_id: 'hmw075ww7tlq',
          id: '72vkct8p5tk8'
        )

        expect(incident).to be_a(StatusPage::Incident)
        expect(incident.page_id).to eq('hmw075ww7tlq')
      end
    end
  end

  describe '#create' do
    context '422 incomplete params' do
      it 'raises error: becuase name can\'t be blank' do
        incident = StatusPage::Incident.new({})

        expect {
          VCR.use_cassette('create_incident_422_incomplete_params') do
            StatusPage::Api::Incident.new
              .create(incident, page_id: 'hmw075ww7tlq')
          end
        }.to raise_error(StatusPage::Error, /Name can't be blank/)
      end
    end

    context '201 incident created' do
      it 'creates a new incident for component on a page' do
        incident = StatusPage::Incident.new('name' => 'Created an Incident')

        VCR.use_cassette('create_incident') do
          created_incident = StatusPage::Api::Incident.new
            .create(incident, page_id: 'hmw075ww7tlq')

          expect(created_incident.name).to eq('Created an Incident')
        end
      end
    end
  end

  describe '#update' do
    context '200 incident is updated' do
      it 'updates status from investigating to identified' do
        incident = VCR.use_cassette('find_incident') do
          StatusPage::Api::Incident.new.find(
            page_id: 'hmw075ww7tlq',
            id: '72vkct8p5tk8'
          )
        end
        expect(incident.status).to eq('investigating')

        incident.component_ids = incident.components.map { |c| c['id'] }

        # #components is a Hash in 'update' and an Array in 'find'
        incident.components = {}
        incident.status = 'identified'

        VCR.use_cassette('update_incident_200_incident_is_updated') do
          updated = StatusPage::Api::Incident.new
            .update(incident,
                    page_id: 'hmw075ww7tlq',
                    id: '72vkct8p5tk8')

          expect(updated.id).to eq('72vkct8p5tk8')
          expect(updated.status).to eq('identified')
        end
      end
    end

    context '400 components is invalid ' do
      it 'errors when the components object is invalid' do
        incident = VCR.use_cassette('find_incident') do
          StatusPage::Api::Incident.new.find(
            page_id: 'hmw075ww7tlq',
            id: '72vkct8p5tk8'
          )
        end

        expect(incident.status).to eq('investigating')

        incident.instance_variable_set(:@status, 'identified')

        VCR.use_cassette('update_incident_400_components_invalid') do
          expect {
            StatusPage::Api::Incident.new
              .update(incident,
                      page_id: 'hmw075ww7tlq',
                      id: '72vkct8p5tk8')
          }.to raise_error(StatusPage::Error)
        end
      end
    end
  end

  # describe '#delete' do
  #   it 'parses all fields correctly' do
  #     page = VCR.use_cassette('find_page') do
  #       StatusPage::Api::Page.new.find('hmw075ww7tlq')
  #     end
  #     expect(page.url).to be_nil

  #     page.instance_variable_set(:@url, 'https://example.com')

  #     updated_page = VCR.use_cassette('update_page_400_page_is_missing') do
  #       StatusPage::Api::Page.new.update('hmw075ww7tlq', page)
  #     end

  #     expect(updated_page.body).to eq('error' => 'page is missing')
  #   end
  # end
end
