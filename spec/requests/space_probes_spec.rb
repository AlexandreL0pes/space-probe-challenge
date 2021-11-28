require 'rails_helper'

RSpec.describe 'SpaceProbes', type: :request do
  describe 'GET /index' do
    let!(:probes) { create_list(:space_probe, 2) }

    it 'show all space probes' do
      get '/space_probes'

      expect(response).to have_http_status(:ok)
      expect(response_body.size).to eq(2)
    end
  end

  describe 'POST /' do
    it 'creates a new probe' do
      post '/space_probes'
      expect(response).to have_http_status(:created)
    end
    it 'creates a new probe' do
      expect do
        post '/space_probes'
      end.to change { SpaceProbe.count }
        .by(1)
    end
  end

  describe 'PUT /:id/initial_position' do
    let(:space_probe) { create(:space_probe) }
    context 'updates probe to 0,0,D' do
      it 'updates position x' do
        expect do
          put "/space_probes/#{space_probe.id}/initial_position"
          space_probe.reload
        end.to change { space_probe.position_x }.from(2).to(0)
      end

      it 'updates position y' do
        expect do
          put "/space_probes/#{space_probe.id}/initial_position"
          space_probe.reload
        end.to change { space_probe.position_y }.from(3).to(0)
      end

      it 'updates front direction' do
        expect do
          put "/space_probes/#{space_probe.id}/initial_position"
          space_probe.reload
        end.to change { space_probe.front_direction }.from('E').to('D')
      end
    end
  end

  describe 'PUT /:id/move' do
    let(:space_probe) { create(:space_probe) }
    let(:commands) { %w[GE M] }
    let(:move_mock) { double(:move) }
    let(:updated_probe) do
      space_probe.update(position_x: 0, position_y: 1, front_direction: 'C')
      space_probe
    end

    context 'when space probe is not found' do
      let(:probe_id) { 404 }
      it 'raises exception' do
        put "/space_probes/#{probe_id}/move"

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'receive an success response' do
      let(:params) do
        {
          commands: commands
        }
      end

      before(:each) do
        allow(SpaceProbe::Move).to receive(:new)
          .with(space_probe: space_probe, commands: commands)
          .and_return(move_mock)

        allow(move_mock).to receive(:call).and_return(updated_probe)
      end

      it do
        put "/space_probes/#{space_probe.id}/move", params: params
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
