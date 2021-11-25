# frozen_string_literal: true

module Fakepay
  class Result
    def initialize(token: nil, error: nil)
      @token = token
      @error = error
    end

    def success?
      error.present?
    end

    private

    attr_reader :error
  end
end
