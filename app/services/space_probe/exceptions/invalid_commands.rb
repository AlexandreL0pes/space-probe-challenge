class SpaceProbe::Exceptions::InvalidCommands < StandardError
  def initialize
    super(I18n.t("services.invalid_commands"))
  end
end