# frozen_string_literal: true

module CmsRedis
  module Core
    RAILS_MAX_THREADS = 16
    REDIS_TIMEOUT = 1
    EXPIRES = 60 * 60

    class Pool
      ## 既存の Pool オブジェクトを受け取るタイプの ConnectionPool::Wrapper
      ## (connection_pool gem の Wrapper は新たな Pool を作成してしまう)
      class Wrapper < ::ConnectionPool::Wrapper
        def initialize(pool)
          @pool = pool
        end
      end

      class << self
        def with(&block)
          pool.with(&block)
        end

        def connect
          ## indicate Wrapper < ::ConnectionPool::Wrapper
          Wrapper.new(pool)
        end

        private

        def pool
          @pool ||= ::ConnectionPool.new(
            size: ENV.fetch("RAILS_MAX_THREADS", RAILS_MAX_THREADS).to_i,
            timeout: ENV.fetch("REDIS_TIMEOUT", REDIS_TIMEOUT).to_i
          ) do
            ::Redis.new(Rails.application.credentials.redis.try(&:to_h))
          end
        end
      end
    end

    class Client
      def initialize(cache_key = "", expires = EXPIRES)
        @connection = ::CmsRedis::Core::Pool.connect
        @cache_key = cache_key
        @expires = expires
      end

      def fetch
        return_array_with_sym = array_with_sym
        return return_array_with_sym unless return_array_with_sym.blank?

        return unless block_given?

        array = yield

        set(array)
        array_with_sym
      end

      def get
        @connection.get(@cache_key)
      end

      def set(array)
        @connection.with do |redis|
          redis.set(@cache_key, array.to_json)
          redis.expire(@cache_key, @expires)
        end
      end

      def del
        @connection.del(@cache_key)
      end

      def cache?
        get.present?
      end

      def array_with_sym
        result = get
        array = ["[]", nil].include?(result) ? [] : result
        return [] if array.blank?

        JSON.parse(array, { symbolize_names: true })
      end
    end
  end
end
