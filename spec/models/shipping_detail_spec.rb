# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShippingDetail, type: :model do
  it { is_expected.to belong_to(:customers_subscription) }
end
