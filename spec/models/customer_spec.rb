# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { is_expected.to have_many(:customers_subscriptions) }
end
