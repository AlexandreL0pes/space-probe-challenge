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

    let(:params) do
      {
        commands: commands
      }
    end

    context 'when space probe is not found' do
      let(:probe_id) { 404 }
      it 'raises exception' do
        put "/space_probes/#{probe_id}/move"

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when commands leads to a invalid position' do
      let(:calculate_mock) { double(:mock) }
      let(:invalid_position) do
        {
          x: 5,
          y: 5,
          dir: 'U'
        }
      end

      before do
        allow(SpaceProbe::CalculatePosition).to receive(:new).and_return(calculate_mock)
        allow(calculate_mock).to receive(:call).and_return(invalid_position)
      end

      it do
        put "/space_probes/#{space_probe.id}/move", params: params
        expect(response).to have_http_status(:bad_request)
      end
    end


    context 'when commands are invalid' do
      let(:commands) { ['GDX', 'M', 'M'] }

      it do
        put "/space_probes/#{space_probe.id}/move", params: params
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'receive an success response' do
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

  describe 'GET /:id' do
    let(:probe) { create(:space_probe) }

    it 'show a specific space probe' do
      get "/space_probes/#{probe.id}/position"

      expect(response).to have_http_status(:ok)
      expect(response_body.keys).to contain_exactly(:id, :position_x, :position_y, :front_direction, :created_at, :updated_at)
    end
  end
end
