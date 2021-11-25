# frozen_string_literal: true

require 'fakepay/result'
require 'fakepay/errors'

module Fakepay
  class ResponseHandler
    def call(response)
      case response.status
      when 200
        parsed_body = parse_body(response)
        Result.new(token: parsed_body['token'])
      when 422
        parsed_body = parse_body(response)
        error_message = map_error_code(parsed_body['error_code'])
        Result.new(error: error_message)
      else
        raise FakepayCallFailure("Failed to call Fakepay: #{response.status}: #{response.body}")
      end
    end

    private

    def parse_body(response)
      JSON.parse(response.body)
    end

    def map_error_code(error_code)
      {
        1_000_001 => 'Invalid credit card number',
        1_000_002 => 'Insufficient funds',
        1_000_003 => 'CVV failure',
        1_000_004 => 'Expired card',
        1_000_005 => 'Invalid zip code',
        1_000_006 => 'Invalid purchase amount',
        1_000_007 => 'Invalid token',
        1_000_008 => 'Invalid params: cannot specify both token and other credit card params'
      }[error_code]
    end
  end
end
