class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: { message: e }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e }, status: :not_found
  end

  rescue_from SpaceProbe::Exceptions::InvalidCommands do |e|
    render json: { message: e }, status: :bad_request
  end
end
