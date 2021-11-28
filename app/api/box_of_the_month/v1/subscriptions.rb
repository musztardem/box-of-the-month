# frozen_string_literal: true

module BoxOfTheMonth
  module V1
    class Subscriptions < Grape::API
      version 'v1', using: :path
      prefix :api

      resource :subscriptions do
        params do
        end
        post do
        end
      end
    end
  end
end
