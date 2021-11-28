# frozen_string_literal: true

require 'fakepay/client'
require 'rails_helper'

RSpec.describe Fakepay::Client do
  subject(:client) { described_class.new(api_key: Rails.configuration.x.fakepay_api_key) }

  describe '#purchase_with_credit_card', vcr: true do
    let(:valid_params) do
      {
        amount: '1000',
        card_number: '4242424242424242',
        cvv: '123',
        expiration_month: '09',
        expiration_year: 3.years.from_now.year.to_s,
        zip_code: '10045'
      }
    end

    subject(:call) { client.purchase_with_credit_card(params: params) }

    context 'when provided params have invalid schema' do
      let(:params) { valid_params.merge(amount: nil) }

      it 'raises InvalidRequestPayload exception' do
        expect { call }.to raise_error(Fakepay::Errors::InvalidRequestPayload)
      end
    end

    context 'when provided params have valid schema but invalid data' do
      let(:params) { valid_params.merge(amount: '-1000') }

      it 'returns Result object with error set' do
        expect(call.error).to eq('Invalid purchase amount')
      end
    end

    context 'when provided params are valid' do
      let(:params) { valid_params }

      it 'returns successful response' do
        expect(call.success?).to be_truthy
      end

      it 'return response with token set' do
        expect(call.token).not_to be_nil
      end
    end
  end

  describe '#purchase_with_token', vcr: true do
    let(:valid_params) do
      {
        amount: '1000',
        token: '99c92b7fd6285a1a55786eca22657c'
      }
    end

    subject(:call) { client.purchase_with_token(params: params) }

    context 'when provided params have invalid schema' do
      let(:params) { valid_params.merge(amount: nil) }

      it 'raises InvalidRequestPayload exception' do
        expect { call }.to raise_error(Fakepay::Errors::InvalidRequestPayload)
      end
    end

    context 'when provided params have valid schema but invalid data' do
      let(:params) { valid_params.merge(amount: '-1000') }

      it 'returns Result object with error set' do
        expect(call.error).to eq('Invalid purchase amount')
      end
    end

    context 'when provided params are valid' do
      let(:params) { valid_params }

      it 'returns successful response' do
        expect(call.success?).to be_truthy
      end

      it 'return response with token set' do
        expect(call.token).not_to be_nil
      end
    end
  end
end
