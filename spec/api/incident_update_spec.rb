# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spage::Api::IncidentUpdate do
  describe '#update' do
    context '200 incident_update is updated' do
      it 'updates status from investigating to identified' do
        incident_update = Spage::IncidentUpdate.new(
          'id' => 'tkd7x7m9t9wc',
          'incident_id' => 'yqr926fhwmh3',
          'body' => 'Empathize with those',
          'twitter_updated_at' => nil,
          'delivery_notifications' => true,
          'wants_twitter_update' => false,
          'affected_components' => [],
          'display_at' => '2022-06-17T19:30:00+00:00',
          'updated_at' => '2022-06-17T19:30:00+00:00',
          'created_at' => '2022-06-17T19:30:00+00:00',
          'page_id' => 'fmd7kj5n71y9'
        )

        VCR.use_cassette('incident_updates/update_200_incident_update_is_updated') do
          updated = Spage::Api::IncidentUpdate.new
            .update(incident_update,
                    'tkd7x7m9t9wc',
                    page_id: 'fmd7kj5n71y9')

          expect(updated.id).to eq('tkd7x7m9t9wc')
          expect(updated.body).to eq('Empathize with those')
        end
      end
    end
  end
end
