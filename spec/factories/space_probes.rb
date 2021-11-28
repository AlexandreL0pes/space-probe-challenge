FactoryBot.define do
  factory :space_probe do
    position_x { 2 }
    position_y { 3 }
    front_direction { 'E' }

    trait :initial_position do
      position_x { 2 }
      position_y { 3 }
      front_direction { 'D' }
    end

    trait :next_to_x_border do
      position_x { 4 }
      position_y { 0 }
      front_direction { 'D' }
    end

    trait :next_to_y_border do
      position_x { 0 }
      position_y { 4 }
      front_direction { 'C' }
    end
  end
end
