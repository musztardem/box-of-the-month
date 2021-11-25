# frozen_string_literal: true

module Fakepay
  class Errors
    InvalidRequestPayload = Class.new(StandardError)
    FakepayCallFailure = Class.new(StandardError)
  end
end
