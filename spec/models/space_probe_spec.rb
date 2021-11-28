require 'rails_helper'

RSpec.describe SpaceProbe, type: :model do
  let(:valid_directions) { %w[E D C B] }
  it do
    should validate_inclusion_of(:position_x).in?(0..4)
  end

  it do
    should validate_inclusion_of(:position_y).in?(0..4)
  end

  it do
    should validate_inclusion_of(:front_direction).in?(valid_directions)
  end

  context 'probe position validation' do
    let(:x_pos) { 0 }
    let(:y_pos) { 1 }
    let(:dir) { 'C' }

    subject { build(:space_probe, position_x: x_pos, position_y: y_pos, front_direction: dir) }

    context 'fails with invalid x' do
      let(:x_pos) { 5 }

      it { expect(subject).to be_invalid }
    end

    context 'fails with invalid y' do
      let(:y_pos) { -1 }

      it { expect(subject).to be_invalid }
    end

    context 'fails with invalid dir' do
      let(:dir) { 'A' }

      it { expect(subject).to be_invalid }
    end

    context 'success with valid data' do
      it { expect(subject).to be_valid }
    end
  end
end
