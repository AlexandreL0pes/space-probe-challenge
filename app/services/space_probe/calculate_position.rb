# frozen_string_literal: true

class SpaceProbe::CalculatePosition
  # TODO: Remember to doc this class
  def initialize(space_probe:, commands:)
    @current_direction = space_probe.front_direction
    @x = space_probe.position_x
    @y = space_probe.position_y
    @commands = commands
  end

  def call
    @commands.each do |command|
      change_direction(command) if %w[GD GE].include? command
      move_spaceprobe if command == 'M'
    end

    {
      x: @x,
      y: @y,
      dir: @current_direction
    }
  end

  private
  
  def change_direction(movement)
    @current_direction = directions[movement][@current_direction]
  end

  def movement_instructions
    positions[@current_direction]
  end

  def move_spaceprobe
    instruction = movement_instructions

    @x += instruction[:amount] if instruction[:axis] == :x
    @y += instruction[:amount] if instruction[:axis] == :y
  end

  def positions
    {
      'C' => {
        axis: :y,
        amount: 1
      },
      'B' => {
        axis: :y,
        amount: -1
      },
      'E' => {
        axis: :x,
        amount: -1
      },
      'D' => {
        axis: :x,
        amount: 1
      }

    }
  end

  def directions
    {
      'GE' => {
        'D' => 'C',
        'E' => 'B',
        'C' => 'E',
        'B' => 'D'
      },
      'GD' => {
        'D' => 'B',
        'E' => 'C',
        'C' => 'D',
        'B' => 'E'
      }
    }
  end
end
