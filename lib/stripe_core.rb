# frozen_string_literal: true

require "stripe"

module StripeCore
  class Charge
    def self.create(_customer_id)
      Stripe::Charge.create(
        amount: 2000,
        currency: "jpy",
        customer: customer_id,
        description: "My First Test Charge (created for API docs at https://www.stripe.com/docs/api)",
        metadata: {
          user_id: 1,
          book_id: 1
        }
      )
      ### 支払いが拒否されるパターン
      ### Stripe::CardErrorが例外キャッチする
      # Stripe::Charge.create(
      #   amount: 2000,
      #   currency: "jpy",
      #   source: "tok_chargeDeclined",
      #   description: "My First Test Charge (created for API docs at https://www.stripe.com/docs/api)",
      #   metadata: {
      #     user_id: 1,
      #     book_id: 1
      #   }
      # )
    rescue Stripe::CardError => e
      # カードエラー（例：不正なカード番号、有効期限切れ等）が発生した場合の処理
      body = e.json_body
      err = body[:error]

      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Charge ID is: #{err[:charge]}"
      puts "Code is: #{err[:code]}"

      puts "Message is: #{err[:message]}"
    rescue Stripe::RateLimitError => e
      # 大量のリクエストによってAPI制限を超えた場合の処理
      # 一時的にリクエストを減らすか、リトライする等の対応が必要
      puts "e=[#{e}]"
    rescue Stripe::InvalidRequestError => e
      # 不正なリクエストパラメータなど、リクエストが不適切だった場合の処理
      puts "e=[#{e}]"
    rescue Stripe::AuthenticationError => e
      # 認証に失敗した場合の処理（APIキーが間違っている可能性が高い）
      puts "e=[#{e}]"
    rescue Stripe::APIConnectionError => e
      # Stripeとのネットワーク接続に問題があった場合の処理
      puts "e=[#{e}]"
    rescue Stripe::StripeError => e
      # その他のStripeのエラーが発生した場合の処理
      puts "e=[#{e}]"
    rescue StandardError => e
      # その他の例外が発生した場合の処理
      puts "e=[#{e}]"
    end

    def self.retrieve(charge_id)
      Stripe::Charge.retrieve(charge_id)
    end
  end

  class Customer
    def self.create_source(customer_id)
      Stripe::Customer.create_source(
        customer_id,
        { source: "tok_visa" }
      )
    end

    def self.create
      Stripe::Customer.create(
        {
          preferred_locales: ["ja-JP"],
          email: "info@mycms.com",
          name: "My CMS管理者",
          description: "My First Test Customer (created for API docs at https://www.stripe.com/docs/api)",
          metadata: {
            admin_id: 1
          }
        }
      )
    end

    def self.retrieve(customer_id)
      Stripe::Customer.retrieve(customer_id)
    end
  end

  class Refund
    def self.create(charge_id)
      Stripe::Refund.create(
        {
          charge: charge_id
        }
      )
    end

    def self.retrieve(refund_id)
      Stripe::Refund.retrieve(refund_id)
    end
  end
end
