# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/subscriptions', type: :request do
  include Dry::Monads[:result]

  subject(:request) { send request_method, path, params: params, headers: headers }

  let(:request_method) { :post }
  let(:path) { '/api/v1/subscriptions' }
  let(:valid_params) do
    {
      customer_id: 1,
      shipping_information: {
        first_name: 'Will',
        last_name: 'Smith',
        address: 'Boulevard of Broken Dreams',
        zip_code: '12345'
      },
      billing_information: {
        card_number: '4111 1111 1111 1111',
        expiration_month: '09',
        expiration_year: '2023',
        cvv: '123',
        zip_code: '43055'
      },
      subscription_plan_id: 1
    }
  end
  let(:headers) { {} }

  context 'when params are invalid' do
    let(:params) { valid_params.merge(customer_id: nil) }

    before { request }

    it 'returns status 400 (:bad_request)' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'return error message' do
      expect(JSON.parse(response.body)['errors']).to include('customer_id is empty')
    end
  end

  context 'when params are valid' do
    let(:params) { valid_params }
    let(:service_mock) { stub_with_dry_matcher(Subscriptions::Create, call: call_result) }

    before do
      allow(Subscriptions::Create).to receive(:new).and_return(service_mock)
      request
    end

    context 'when customer does not exist' do
      let(:call_result) { Failure([:not_found, 'Customer']) }

      it 'returns status 404 (:not_found)' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when subscription_plan does not exist' do
      let(:call_result) { Failure([:not_found, 'Subscription Plan']) }

      it 'returns status 404 (:not_found)' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when payment fails' do
      let(:call_result) { Failure([:payment_failed, 'Payment Failed']) }

      it 'returns status 422 (:unprocessable_entity)' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
