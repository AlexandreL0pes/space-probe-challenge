class SpaceProbesController < ApplicationController
  before_action :set_space_probe, only: %i[show reset move]

  def index
    render json: SpaceProbe.all
  end

  def create
    @space_probe = SpaceProbe.create(position_x: 0, position_y: 0, front_direction: 'D')

    render json: @space_probe, status: :created
  end

  def show
    render json: @space_probe
  end

  def move
    @space_probe = SpaceProbe::Move.new(space_probe: @space_probe, commands: params[:commands]).call

    render json: @space_probe
  end

  def reset
    @space_probe.update(position_x: 0, position_y: 0, front_direction: 'D')

    head :ok
  end

  private

  def set_space_probe
    @space_probe = SpaceProbe.find(params[:id])
  end
end
