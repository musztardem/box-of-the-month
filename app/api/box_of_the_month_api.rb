# frozen_string_literal: true

class BoxOfTheMonthApi < ApiBase
  mount BoxOfTheMonth::V1::Subscriptions
end
