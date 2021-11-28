# frozen_string_literal: true

module Requests
  def response_body
    JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include Requests, type: :request
end
