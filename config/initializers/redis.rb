# frozen_string_literal: true

client_option = Rails.application.credentials.redis.try(&:to_h) || {}
Redis.current = Redis.new(client_option)
