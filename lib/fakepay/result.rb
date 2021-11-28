# frozen_string_literal: true

module Fakepay
  class Result
    attr_reader :token, :error

    def initialize(token: nil, error: nil)
      @token = token
      @error = error
    end

    def success?
      error.blank?
    end
  end
end
