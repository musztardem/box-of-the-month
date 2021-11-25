# frozen_string_literal: true

require 'fakepay/requests/purchase_with_credit_card_request'
require 'fakepay/requests/purchase_with_token_request'
require 'fakepay/errors'
require 'fakepay/response_handler'

module Fakepay
  class Client
    BASE_URL = 'https://www.fakepay.io'

    def initialize(api_key:)
      @api_key = api_key
      @response_handler = ResponseHandler.new
    end

    def purchase_with_credit_card(params: {})
      body = validated_request_params(
        params: params,
        request_contract: Requests::PurchaseWithCreditCardRequest.new
      )
      response = purchase(body: body)
      response_handler.call(response)
    end

    def purchase_with_token(params: {})
      body = validated_request_params(
        params: params,
        request_contract: Requests::PurchaseWithTokenRequest.new
      )
      response = purchase(body: body)
      response_handler.call(response)
    end

    private

    def validated_request_params(params:, request_contract:)
      contract_result = request_contract.call(params)
      raise Errors::InvalidRequestPayload if contract_result.errors.any?

      contract_result.to_h
    end

    def purchase(body: {})
      Faraday.post(purchase_url, body.to_json, auth_headers)
    end

    def purchase_url
      "#{BASE_URL}/purchase"
    end

    def auth_headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Token token=#{api_key}"
      }
    end

    attr_reader :api_key, :response_handler
  end
end
