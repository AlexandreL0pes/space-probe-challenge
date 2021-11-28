class SpaceProbe::Move
  def initialize(space_probe_id:, commands:)
    @space_probe = SpaceProbe.find(space_probe_id)
    @commands = commands
  end

  def call
    raise_invalid_commands unless valid_commands?

    position = SpaceProbe::CalculatePosition.new(space_probe: space_probe, commands: commands)

    space_probe.update!(position_x: position[:x], position_y: position[:y], front_direction: position[:dir])

    space_probe
  end

  private

  attr_accessor :commands, :space_probe

  def valid_commands?
    (commands - ['GE', 'GD', 'M']).empty?
  end

  def raise_invalid_commands
    raise SpaceProbe::Exceptions::InvalidCommands.new
  end
end