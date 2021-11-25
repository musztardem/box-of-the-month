# frozen_string_literal: true

require 'fakepay/result'
require 'fakepay/errors'

module Fakepay
  class ResponseHandler

    def call(response)
      binding.pry
      case response.status
      when 200
        parsed_body = parse_body(response)
        Result.new(token: parsed_body['token'])
      when 422
        parsed_body = parse_body(response)
        error_message = map_error_code(parsed_body['error_code'])
        return Result.new(error: error_message)
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
        1000001 => 'Invalid credit card number',
        1000002 => 'Insufficient funds',
        1000003 => 'CVV failure',
        1000004 => 'Expired card',
        1000005 => 'Invalid zip code',
        1000006 => 'Invalid purchase amount',
        1000007 => 'Invalid token',
        1000008 => 'Invalid params: cannot specify both token and other credit card params'
      }[error_code]
    end
  end
end
