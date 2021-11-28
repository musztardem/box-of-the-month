# frozen_string_literal: true

require 'dry/matcher/result_matcher'

module Subscriptions
  class Create
    include Dry::Monads[:result, :do]
    include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

    def initialize; end

    def call
      Success(nil)
    end
  end
end
