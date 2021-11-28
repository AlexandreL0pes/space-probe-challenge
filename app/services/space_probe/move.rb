class SpaceProbe::Move
  def initialize(space_probe:, commands:)
    @space_probe = space_probe
    @commands = commands
  end

  def call
    raise_invalid_commands unless valid_commands?

    position = SpaceProbe::CalculatePosition.new(space_probe: space_probe, commands: commands).call
    space_probe.update!(position_x: position[:x], position_y: position[:y], front_direction: position[:dir])

    space_probe
  end

  private

  attr_accessor :commands, :space_probe

  def valid_commands?
    return false if commands.nil?
    
    (commands - %w[GE GD M]).empty?
  end

  def raise_invalid_commands
    raise SpaceProbe::Exceptions::InvalidCommands
  end
end
