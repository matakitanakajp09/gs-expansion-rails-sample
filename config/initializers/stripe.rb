# frozen_string_literal: true

### Stripe::StripeConfigurationをオーバーライドして、Rails.application.credentialsから秘匿情報をセットする
module Stripe
  class StripeConfiguration
    def api_key=(key_value)
      @api_key = key_value || Rails.application.credentials.stripe.secret_key
    end
  end
end

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.stripe.publishable_key,
  secret_key: Rails.application.credentials.stripe.secret_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_version = "2022-11-15"
