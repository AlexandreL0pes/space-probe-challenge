class SpaceProbe < ApplicationRecord
  validates :front_direction, inclusion: { in: %w[E D C B] }
  validates :position_x, inclusion: 0..4
  validates :position_y, inclusion: 0..4
end
