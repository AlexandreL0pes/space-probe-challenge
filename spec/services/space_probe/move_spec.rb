require 'rails_helper'

RSpec.describe SpaceProbe::Move do
  let(:probe) { create(:space_probe, :initial_position) }
  let(:probe_id) { probe.id }
  let(:commands) { ['GE', 'M', 'M', 'M', 'GD', 'M', 'M']}

  subject { described_class.new(space_probe_id: probe_id, commands: commands) }

  describe 'when commands' do
    let(:commands) { ['EG', 'M', 'M']}
    
    context 'are invalid' do
      it 'raises exception' do
        expect do 
          subject.call
        end.to raise_error(SpaceProbe::Exceptions::InvalidCommands)
      end
    end
  end

  describe 'when probe' do
    context 'is not found' do
      let(:probe_id) { 404 }
      it 'raises exception' do
        expect do 
          subject.call
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end


  describe 'when commands and probe are valid' do
    let(:calculated_position) do
      {
        x: 2,
        y: 3,
        dir: 'D'
      }
    end
    before(:each) do
      allow(SpaceProbe::CalculatePosition).to receive(:new)
        .with(space_probe: probe, commands: commands)
        .and_return(calculated_position)
    end

    it 'updates probe position' do
      subject.call
    
      probe.reload
      expect(probe.position_x).to eq(2)
      expect(probe.position_y).to eq(3)
      expect(probe.front_direction).to eq('D')
    end
    
    context 'returns updated probe' do
      it do
        expect(subject.call).to eq(probe.reload)
      end
    end
  end
end
