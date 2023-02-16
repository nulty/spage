# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spage::Api::Incident do
  describe '#all' do
    it 'returns a collection of Incidents' do
      VCR.use_cassette('incidents/all') do
        incidents = Spage::Api::Incident.new.all(page_id: 'fmd7kj5n71y9')

        expect(incidents).to respond_to(:each)
        expect(incidents.first).to be_a(Spage::Incident)
        expect(incidents.first.id).to eq('t3zy7x9tny6h')
      end
    end

    context 'with per_page=1&page=2' do
      let(:page_id) { 'fmd7kj5n71y9' }

      around do |ex|
        VCR.use_cassette('incidents/paginated') do
          ex.run
        end
      end

      it 'returns paginated incidents' do
        api = Spage::Api::Incident.new
        incidents = api.all(page_id:, per_page: 1, page: 1)

        expect(incidents.count).to eq(1)
        expect(incidents.first.id).to eq('t3zy7x9tny6h')

        incidents = api.all(page_id:, per_page: 1, page: 2)

        expect(incidents.count).to eq(1)
        expect(incidents.first.id).to eq('pqp4tk19c0l4')
      end
    end
  end

  describe '#find' do
    it 'returns an Incident' do
      VCR.use_cassette('incidents/find') do
        incident = Spage::Api::Incident.new.find(
          page_id: 'hmw075ww7tlq',
          id: '72vkct8p5tk8'
        )

        expect(incident).to be_a(Spage::Incident)
        expect(incident.page_id).to eq('hmw075ww7tlq')
      end
    end
  end

  describe '#create' do
    context '422 incomplete params' do
      it 'raises error: becuase name can\'t be blank' do
        incident = Spage::Incident.new({})

        expect {
          VCR.use_cassette('incidents/create_422_incomplete_params') do
            Spage::Api::Incident.new
              .create(incident, page_id: 'hmw075ww7tlq')
          end
        }.to raise_error(Spage::Error, /Name can't be blank/)
      end
    end

    context '201 incident created' do
      it 'creates a new incident for component on a page' do
        incident = Spage::Incident.new('name' => 'Created an Incident')

        VCR.use_cassette('incidents/create') do
          created_incident = Spage::Api::Incident.new
            .create(incident, page_id: 'hmw075ww7tlq')

          expect(created_incident.name).to eq('Created an Incident')
        end
      end
    end
  end

  describe '#update' do
    context '200 incident is updated' do
      it 'updates status from investigating to identified' do
        incident = VCR.use_cassette('incidents/find') do
          Spage::Api::Incident.new.find(
            page_id: 'hmw075ww7tlq',
            id: '72vkct8p5tk8'
          )
        end
        expect(incident.status).to eq('investigating')

        incident.component_ids = incident.components.map { |c| c['id'] }

        # #components is a Hash in 'update' and an Array in 'find'
        incident.components = {}
        incident.status = 'identified'

        VCR.use_cassette('incidents/update_200_incident_is_updated') do
          updated = Spage::Api::Incident.new
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
        incident = VCR.use_cassette('incidents/find') do
          Spage::Api::Incident.new.find(
            page_id: 'hmw075ww7tlq',
            id: '72vkct8p5tk8'
          )
        end

        expect(incident.status).to eq('investigating')

        incident.instance_variable_set(:@status, 'identified')

        VCR.use_cassette('incidents/update_400_components_invalid') do
          expect {
            Spage::Api::Incident.new
              .update(incident,
                      page_id: 'hmw075ww7tlq',
                      id: '72vkct8p5tk8')
          }.to raise_error(Spage::Error)
        end
      end
    end
  end

  describe '#unresolved_incidents' do
    context '200 success' do
      it 'returns list of unresolved incidents' do
        incidents = VCR.use_cassette('incidents/unresolved') do
          Spage::Api::Incident.new.unresolved(
            page_id: 'hmw075ww7tlq'
          )
        end
        expect(incidents.length).to eq(3)

        expect(incidents.map(&:status)).to(
          match_array(%w[investigating identified monitoring])
        )
      end
    end
  end

  describe '#active_maintenance' do
    context '200 success' do
      it 'returns list of active maintenance incidents' do
        incidents = VCR.use_cassette('incidents/active_maintenance') do
          Spage::Api::Incident.new.active_maintenance(
            page_id: 'hmw075ww7tlq'
          )
        end

        expect(incidents.all? { |i| i.status == 'in_progress' }).to be(true)
      end
    end
  end

  describe '#scheduled' do
    context '200 success' do
      it 'returns list of scheduled incidents' do
        incidents = VCR.use_cassette('incidents/scheduled') do
          Spage::Api::Incident.new.scheduled(
            page_id: 'hmw075ww7tlq'
          )
        end

        expect(incidents.all? { |i| i.status == 'scheduled' }).to be(true)
      end
    end
  end

  describe '#delete' do
    it 'deletes an incident' do
      incident = VCR.use_cassette('incidents/delete') do
        Spage::Api::Incident.new.delete(
          page_id: 'hmw075ww7tlq',
          id: 'w0x7fxxlprmx'
        )
      end

      expect(incident.id).to eq('w0x7fxxlprmx')
    end
  end
end
