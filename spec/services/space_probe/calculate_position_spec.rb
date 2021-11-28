require 'rails_helper'

RSpec.describe SpaceProbe::CalculatePosition do
  
  subject { described_class.new(space_probe: space_probe, commands: commands) }

  describe 'when probe is in inital position' do
    let(:space_probe) { create(:space_probe, :initial_position) }
    
    context 'move to (2,3,D)' do
      let(:commands) { ['GE', 'M', 'M', 'M', 'GD', 'M', 'M'] }

      it { expect(subject.call).to eq({x: 2, y: 3, dir: 'D'}) } 
    end

    context 'move to straight to the right' do
      let(:commands) { ['M', 'M', 'M', 'M'] }

      it { expect(subject.call).to eq({x: 4, y: 0, dir: 'D'}) } 
    end

    context 'move up' do
      let(:commands) { ['GE', 'M', 'M', 'M', 'M'] }

      it { expect(subject.call).to eq({x: 0, y: 4, dir: 'C'}) } 
    end

    context 'moves to the opposite side' do
      let(:commands) { ['M', 'GE', 'M', 'GD', 'M', 'GE', 'M', 'GD', 'M' , 'GE', 'M', 'GD', 'M', 'GE', 'M'] }

      it { expect(subject.call).to eq({x: 4, y: 4, dir: 'C'}) } 
    end
  end

  describe 'when probe only change face direction' do
    let(:space_probe) { create(:space_probe, :initial_position) }

    context 'turning to left' do
      let(:commands) { ['GE', 'GE', 'GE'] }

      it { expect(subject.call).to eq({x: 0, y: 0, dir: 'B'}) } 
    end

    context 'turning to left' do
      let(:commands) { ['GE', 'GE'] }

      it { expect(subject.call).to eq({x: 0, y: 0, dir: 'E'}) } 
    end

    context 'turning to right' do
      let(:commands) { ['GD', 'GD', 'GD'] }

      it { expect(subject.call).to eq({x: 0, y: 0, dir: 'C'}) } 
    end

    context 'turning and go back to initial direction' do
      let(:commands) { ['GD', 'GD', 'GD', 'GD'] }

      it { expect(subject.call).to eq({x: 0, y: 0, dir: 'D'}) } 
    end
  end

  describe 'when probe is in x limit' do
    let(:space_probe) { create(:space_probe, :next_to_x_border) }

    context 'move up to the limit' do
      let(:commands) { ['GE', 'M', 'M', 'M', 'M'] }

      it { expect(subject.call).to eq({x: 4, y: 4, dir: 'C'}) } 
    end
  end

  describe 'when probe is in y limit' do
    let(:space_probe) { create(:space_probe, :next_to_y_border) }

    context 'move up to the limit' do
      let(:commands) { ['GD', 'M', 'M', 'M', 'M'] }

      it { expect(subject.call).to eq({x: 4, y: 4, dir: 'D'}) } 
    end
  end

  describe 'when proble is in x and y limit' do
    let(:space_probe) { create(:space_probe, :in_x_and_y_limit) }

    context 'move down' do
      let(:commands) { ['GD', 'M', 'M', 'M', 'M'] }

      it { expect(subject.call).to eq({x: 4, y: 0, dir: 'B'}) } 
    end

    context 'move down' do
      let(:commands) { ['GE', 'GE', 'M', 'M', 'M', 'M'] }

      it { expect(subject.call).to eq({x: 0, y: 4, dir: 'E'}) } 
    end
  end
end