# frozen_string_literal: true

require 'spec_helper'
require 'fakepay/client'

RSpec.describe Fakepay::Client do
  subject(:client) { described_class.new(api_key: Rails.configuration.x.fakepay_api_key) }

  describe '#purchase_with_credit_card' do
    it 'does something' do
    end
  end

  describe '#purchase_with_token' do
    it 'also does something' do
    end
  end
end
