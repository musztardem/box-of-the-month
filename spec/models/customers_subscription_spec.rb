# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomersSubscription, type: :model do
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to belong_to(:subscription_plan) }

  it { is_expected.to have_one(:shipping_detail) }
  it { is_expected.to have_one(:payment_detail) }
end
